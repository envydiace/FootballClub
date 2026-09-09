//
//  GameDetailView.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import SwiftUI

struct GameDetailView: View {

    let game: WeeklyFootballGame
    let dependencies: AppDependencies

    @State private var viewModel: GameDetailViewModel

    init(
        game: WeeklyFootballGame,
        dependencies: AppDependencies
    ) {
        self.game = game
        self.dependencies = dependencies

        _viewModel = State(
            initialValue: GameDetailViewModel(
                repository:
                    dependencies.registrationRepository,
                currentMember:
                    dependencies.currentMember
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 24
            ) {

                VStack(
                    alignment: .leading,
                    spacing: 8
                ) {
                    Text(game.gameName)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Label(
                        game.kickOffAt.formatted(
                            date: .complete,
                            time: .shortened
                        ),
                        systemImage: "calendar"
                    )

                    Label(
                        game.venueName,
                        systemImage:
                            "mappin.and.ellipse"
                    )
                }

                Divider()

                VStack(
                    alignment: .leading,
                    spacing: 8
                ) {
                    Text("Game Information")
                        .font(.headline)

                    Label(
                        "\(game.playerCapacity) player capacity",
                        systemImage: "person.3"
                    )

                    Text(
                        "Registration closes \(game.registrationClosesAt.formatted(date: .abbreviated, time: .shortened))"
                    )
                    .foregroundStyle(.secondary)
                }

                Divider()

                Button {
                    viewModel.register(
                        for: game
                    )
                } label: {
                    Text("Register for Game")
                        .frame(
                            maxWidth: .infinity
                        )
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                
                if dependencies.currentMember.role == .organiser {

                    NavigationLink {
                        ManageGameView(
                            game: game,
                            dependencies: dependencies
                        )
                    } label: {
                        Text("Manage Game")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }

                if let registration = viewModel.currentRegistration {

                    switch registration.registrationStatus {

                    case .confirmed:
                        Text("You are confirmed for this game.")
                            .foregroundStyle(.green)

                    case .waitlisted:
                        Text("The game is full. You have been added to the waitlist.")
                            .foregroundStyle(.orange)

                    case .cancelled:
                        Text("You have cancelled your registration for this game.")
                            .foregroundStyle(.red)
                    }

                } else if let errorMessage = viewModel.errorMessage {

                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.loadCurrentRegistration(
                for: game
            )
        }
        .navigationTitle("Game Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
