//
//  ManageGameView.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import SwiftUI

struct ManageGameView: View {

    let game: WeeklyFootballGame
    let dependencies: AppDependencies

    @State private var viewModel: ManageGameViewModel

    init(
        game: WeeklyFootballGame,
        dependencies: AppDependencies
    ) {
        self.game = game
        self.dependencies = dependencies

        _viewModel = State(
            initialValue: ManageGameViewModel(
                registrationRepository:
                    dependencies.registrationRepository,
                memberRepository:
                    dependencies.memberRepository
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                // Game summary
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text(game.gameName)
                        .font(.title2)
                        .fontWeight(.bold)

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

                    HStack {
                        Text(
                            "\(viewModel.confirmedPlayers.count)/\(game.playerCapacity) players"
                        )

                        Spacer()

                        Text(
                            "\(spotsLeft) spots left"
                        )
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
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

                // Confirmed players
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text("Registered Players")
                        .font(.headline)

                    if viewModel.confirmedPlayers.isEmpty {
                        Text("No confirmed players")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(
                            viewModel.confirmedPlayers
                        ) { item in

                            HStack {
                                Text(item.member.fullName)

                                Spacer()

                                Image(
                                    systemName:
                                        "checkmark.circle.fill"
                                )
                                .foregroundStyle(.green)
                            }
                        }
                    }
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

                // Waitlist
                VStack(
                    alignment: .leading,
                    spacing: 10
                ) {
                    Text("Waitlist")
                        .font(.headline)

                    if viewModel.waitlistedPlayers.isEmpty {
                        Text("Waitlist is empty")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(
                            Array(
                                viewModel.waitlistedPlayers.enumerated()
                            ),
                            id: \.element.id
                        ) { index, item in

                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.member.fullName)

                                    Text(
                                        "Waitlist #\(index + 1)"
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Image(systemName: "clock")
                            }
                        }
                    }
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

                // Actions
                VStack(spacing: 10) {

                    Button {
                        viewModel
                            .promoteFirstWaitlistedPlayer(
                                for: game
                            )
                    } label: {
                        Text("Promote First Waitlisted Player")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(
                        viewModel.waitlistedPlayers.isEmpty
                    )

                    Button {
                        // Placeholder for future organiser action
                    } label: {
                        Text("Edit Game")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }

                if let message = viewModel.message {
                    Text(message)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Manage Game")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadRegistrations(
                for: game
            )
        }
    }

    private var spotsLeft: Int {
        max(
            game.playerCapacity -
            viewModel.confirmedPlayers.count,
            0
        )
    }
}

#Preview {
    NavigationStack {
        ManageGameView(
            game: MockFootballData.weeklyGames[0],
            dependencies: AppDependencies()
        )
    }
}
