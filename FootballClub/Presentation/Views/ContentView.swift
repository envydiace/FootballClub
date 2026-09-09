//
//  ContentView.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import SwiftUI

struct ContentView: View {

    let dependencies: AppDependencies

    var body: some View {
        TabView {

            UpcomingGamesView(
                dependencies: dependencies
            )
            .tabItem {
                Label(
                    "Games",
                    systemImage: "calendar"
                )
            }

            MyRegistrationsView(
                dependencies: dependencies
            )
            .tabItem {
                Label(
                    "My Registrations",
                    systemImage: "person.crop.circle.badge.checkmark"
                )
            }
        }
    }
}

#Preview {
    ContentView(
        dependencies: AppDependencies()
    )
}
