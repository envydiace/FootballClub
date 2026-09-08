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
        UpcomingGamesView(
            dependencies: dependencies
        )
    }
}

#Preview {
    ContentView(
        dependencies: AppDependencies()
    )
}
