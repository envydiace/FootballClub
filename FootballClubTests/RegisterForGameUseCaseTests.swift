//
//  RegisterForGameUseCaseTests.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import Testing
import Foundation
@testable import FootballClub

struct RegisterForGameUseCaseTests {

    private func makeMember() -> ClubMember {
        ClubMember(
            id: UUID(),
            fullName: "Alex Nguyen",
            emailAddress: "alex@example.com",
            role: .member
        )
    }

    private func makeGame(
        capacity: Int = 2
    ) -> WeeklyFootballGame {

        WeeklyFootballGame(
            id: UUID(),
            gameName: "Sunday Football",
            venueName: "Sydney Football Park",
            kickOffAt: Date(timeIntervalSince1970: 5_000),
            finishesAt: Date(timeIntervalSince1970: 6_000),
            playerCapacity: capacity,
            registrationOpensAt: Date(timeIntervalSince1970: 1_000),
            registrationClosesAt: Date(timeIntervalSince1970: 4_000)
        )
    }

    @Test
    func registrationBeforeOpeningDateThrowsError() throws {

        let repository = InMemoryWeeklyGameRegistrationRepository()
        let useCase = RegisterForGameUseCase(repository: repository)

        let member = makeMember()
        let game = makeGame()

        #expect(
            throws: WeeklyGameRegistrationError.registrationNotOpen
        ) {
            try useCase.execute(
                member: member,
                game: game,
                currentDate: Date(timeIntervalSince1970: 500)
            )
        }
    }

    @Test
    func registrationAfterClosingDateThrowsError() throws {

        let repository = InMemoryWeeklyGameRegistrationRepository()
        let useCase = RegisterForGameUseCase(repository: repository)

        let member = makeMember()
        let game = makeGame()

        #expect(
            throws: WeeklyGameRegistrationError.registrationClosed
        ) {
            try useCase.execute(
                member: member,
                game: game,
                currentDate: Date(timeIntervalSince1970: 4_500)
            )
        }
    }

    @Test
    func registrationIsConfirmedWhenSpaceIsAvailable() throws {

        let repository = InMemoryWeeklyGameRegistrationRepository()
        let useCase = RegisterForGameUseCase(repository: repository)

        let member = makeMember()
        let game = makeGame()

        let registration = try useCase.execute(
            member: member,
            game: game,
            currentDate: Date(timeIntervalSince1970: 2_000)
        )

        #expect(registration.registrationStatus == .confirmed)
    }

    @Test
    func duplicateRegistrationThrowsError() throws {

        let repository = InMemoryWeeklyGameRegistrationRepository()
        let useCase = RegisterForGameUseCase(repository: repository)

        let member = makeMember()
        let game = makeGame()

        _ = try useCase.execute(
            member: member,
            game: game,
            currentDate: Date(timeIntervalSince1970: 2_000)
        )

        #expect(
            throws: WeeklyGameRegistrationError.alreadyRegistered
        ) {
            try useCase.execute(
                member: member,
                game: game,
                currentDate: Date(timeIntervalSince1970: 2_100)
            )
        }
    }

    @Test
    func registrationIsWaitlistedWhenGameIsFull() throws {

        let repository = InMemoryWeeklyGameRegistrationRepository()
        let useCase = RegisterForGameUseCase(repository: repository)

        let game = makeGame(capacity: 1)

        let firstMember = makeMember()
        let secondMember = makeMember()

        _ = try useCase.execute(
            member: firstMember,
            game: game,
            currentDate: Date(timeIntervalSince1970: 2_000)
        )

        let secondRegistration = try useCase.execute(
            member: secondMember,
            game: game,
            currentDate: Date(timeIntervalSince1970: 2_100)
        )

        #expect(secondRegistration.registrationStatus == .waitlisted)
    }
}
