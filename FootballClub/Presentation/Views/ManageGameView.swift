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
        List {

            Section("Game") {
                VStack(
                    alignment: .leading,
                    spacing: 6
                ) {
                    Text(game.gameName)
                        .font(.headline)

                    Text(game.venueName)

                    Text(
                        game.kickOffAt.formatted(
                            date: .abbreviated,
                            time: .shortened
                        )
                    )
                    .foregroundStyle(.secondary)
                }
            }

            Section(
                "Confirmed Players (\(viewModel.confirmedPlayers.count)/\(game.playerCapacity))"
            ) {

                if viewModel.confirmedPlayers.isEmpty {
                    Text("No confirmed players")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(viewModel.confirmedPlayers) { item in
                        Label(
                            item.member.fullName,
                            systemImage: "checkmark.circle.fill"
                        )
                    }
                }
            }

            Section(
                "Waitlist (\(viewModel.waitlistedPlayers.count))"
            ) {

                if viewModel.waitlistedPlayers.isEmpty {

                    Text("Waitlist is empty")
                        .foregroundStyle(.secondary)

                } else {

                    ForEach(
                        Array(viewModel.waitlistedPlayers.enumerated()),
                        id: \.element.id
                    ) { index, item in

                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.member.fullName)
                                Text("Waitlist #\(index + 1)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Image(systemName: "clock")
                        }
                    }

                    Button(
                        "Promote First Waitlisted Player"
                    ) {
                        viewModel
                            .promoteFirstWaitlistedPlayer(
                                for: game
                            )
                    }
                }
            }

            if let message = viewModel.message {
                Section {
                    Text(message)
                }
            }
        }
        .navigationTitle("Manage Game")
        .onAppear {
            viewModel.loadRegistrations(
                for: game
            )
        }
    }
}
