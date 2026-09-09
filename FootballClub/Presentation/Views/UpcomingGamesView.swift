//
//  UpcomingGamesView.swift
//  FootballClub
//
//  Created by Đức Anh on 8/9/26.
//

import SwiftUI

struct UpcomingGamesView: View {

    let dependencies: AppDependencies

    @State private var viewModel: UpcomingGamesViewModel

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies

        _viewModel = State(
            initialValue: UpcomingGamesViewModel(
                repository: dependencies.gameRepository
            )
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    ForEach(viewModel.games) { game in

                        VStack(
                            alignment: .leading,
                            spacing: 12
                        ) {

                            HStack {
                                Text(game.gameName)
                                    .font(.headline)

                                Spacer()

                                Text(gameStatus(for: game))
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(.green.opacity(0.15))
                                    .clipShape(Capsule())
                            }

                            Label(
                                game.kickOffAt.formatted(
                                    date: .abbreviated,
                                    time: .shortened
                                ),
                                systemImage: "clock"
                            )

                            Label(
                                game.venueName,
                                systemImage: "mappin.and.ellipse"
                            )

                            Label(
                                "\(confirmedPlayerCount(for: game))/\(game.playerCapacity) players",
                                systemImage: "person"
                            )

                            Text(
                                "\(spotsLeft(for: game)) spots left"
                            )
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                            NavigationLink {
                                GameDetailView(
                                    game: game,
                                    dependencies: dependencies
                                )
                            } label: {
                                Text("View Details")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.background)
                                .shadow(
                                    color: .black.opacity(0.08),
                                    radius: 4
                                )
                        )
                    }
                }
                .padding()
            }
            .navigationTitle("Upcoming Games")
        }
    }

    private func confirmedPlayerCount(
        for game: WeeklyFootballGame
    ) -> Int {

        dependencies.registrationRepository
            .registrations(for: game.id)
            .filter {
                $0.registrationStatus == .confirmed
            }
            .count
    }

    private func spotsLeft(
        for game: WeeklyFootballGame
    ) -> Int {

        max(
            game.playerCapacity -
            confirmedPlayerCount(for: game),
            0
        )
    }

    private func gameStatus(
        for game: WeeklyFootballGame
    ) -> String {

        let now = Date()

        if now < game.registrationOpensAt {
            return "Not Open"
        }

        if now > game.registrationClosesAt {
            return "Closed"
        }

        return "Open"
    }
}

#Preview {
    UpcomingGamesView(
        dependencies: AppDependencies()
    )
}
