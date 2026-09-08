//
//  UpcomingGamesView.swift
//  FootballClub
//
//  Created by Đức Anh on 8/9/26.
//

import SwiftUI

struct UpcomingGamesView: View {

    let dependencies: AppDependencies

    @State private var viewModel =
        UpcomingGamesViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.games) { game in

                NavigationLink {
                    GameDetailView(
                        game: game,
                        dependencies: dependencies
                    )
                } label: {
                    VStack(
                        alignment: .leading,
                        spacing: 6
                    ) {

                        Text(game.gameName)
                            .font(.headline)

                        Text(game.venueName)
                            .font(.subheadline)

                        Text(
                            game.kickOffAt.formatted(
                                date: .abbreviated,
                                time: .shortened
                            )
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Upcoming Games")
        }
    }
}
