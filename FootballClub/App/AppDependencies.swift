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
    let memberRepository: InMemoryClubMemberRepository

    let currentMember: ClubMember

    init() {

        let games = MockFootballData.weeklyGames
        let members = MockFootballData.members

        self.registrationRepository =
            InMemoryWeeklyGameRegistrationRepository()

        self.gameRepository =
            InMemoryWeeklyFootballGameRepository(
                games: games
            )

        self.memberRepository =
            InMemoryClubMemberRepository(
                members: members
            )

        self.currentMember = members[0]
    }
}
