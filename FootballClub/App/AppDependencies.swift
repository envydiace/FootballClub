//
//  AppDependencies.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

final class AppDependencies {

    let registrationRepository: InMemoryWeeklyGameRegistrationRepository
    let gameRepository: InMemoryWeeklyFootballGameRepository
    let memberRepository: InMemoryClubMemberRepository

    var currentMember: ClubMember

    init() {
        let games = MockFootballData.weeklyGames
        let members = MockFootballData.members

        registrationRepository =
            InMemoryWeeklyGameRegistrationRepository(
                registrations: MockFootballData.registrations
            )

        gameRepository =
            InMemoryWeeklyFootballGameRepository(
                games: games
            )

        memberRepository =
            InMemoryClubMemberRepository(
                members: members
            )

        currentMember = members[0]
    }

    func switchToMember() {
        currentMember = MockFootballData.members.first {
            $0.role == .member
        }!
    }

    func switchToOrganiser() {
        currentMember = MockFootballData.members.first {
            $0.role == .organiser
        }!
    }
}
