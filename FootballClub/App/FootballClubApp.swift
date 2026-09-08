//
//  FootballClubApp.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import SwiftUI

@main
struct FootballClubApp: App {

    private let dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            ContentView(
                dependencies: dependencies
            )
        }
    }
}
