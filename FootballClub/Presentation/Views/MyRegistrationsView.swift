//
//  MyRegistrationsView.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import SwiftUI

struct MyRegistrationsView: View {

    let dependencies: AppDependencies

    @State private var viewModel: MyRegistrationsViewModel

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies

        _viewModel = State(
            initialValue: MyRegistrationsViewModel(
                registrationRepository: dependencies.registrationRepository,
                gameRepository: dependencies.gameRepository,
                currentMember: dependencies.currentMember
            )
        )
    }

    var body: some View {
        NavigationStack {
            List {
                if viewModel.items.isEmpty {
                    ContentUnavailableView(
                        "No Registrations",
                        systemImage: "calendar.badge.exclamationmark",
                        description: Text(
                            "You have not registered for any games yet."
                        )
                    )
                } else {
                    ForEach(viewModel.items) { item in

                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {

                            Text(item.game.gameName)
                                .font(.headline)

                            Text(item.game.venueName)

                            Text(
                                item.game.kickOffAt.formatted(
                                    date: .abbreviated,
                                    time: .shortened
                                )
                            )
                            .foregroundStyle(.secondary)

                            Text(
                                item.registration.registrationStatus == .confirmed
                                ? "Confirmed"
                                : "Waitlisted"
                            )
                            .fontWeight(.semibold)

                            Button(role: .destructive) {
                                viewModel.cancelRegistration(
                                    for: item.game
                                )
                            } label: {
                                Text("Cancel Registration")
                            }
                            .buttonStyle(.borderless)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("My Registrations")
            .onAppear {
                viewModel.loadRegistrations()
            }
        }
    }
}
