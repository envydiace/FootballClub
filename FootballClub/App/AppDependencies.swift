//
//  AppDependencies.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation

final class AppDependencies {

    let registrationRepository: InMemoryWeeklyGameRegistrationRepository
    let gameRepository: InMemoryWeeklyFootballGameRepository
    let currentMember: ClubMember

    init() {
        let games = MockFootballData.weeklyGames

        self.registrationRepository =
            InMemoryWeeklyGameRegistrationRepository()

        self.gameRepository =
            InMemoryWeeklyFootballGameRepository(
                games: games
            )

        self.currentMember = ClubMember(
            id: UUID(),
            fullName: "Alex Nguyen",
            emailAddress: "alex@example.com"
        )
    }
}
