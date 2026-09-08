//
//  PromoteWaitlistedPlayerUseCaseTests.swift
//  FootballClub
//
//  Created by Đức Anh on 8/9/26.
//

import Testing
import Foundation
@testable import FootballClub

struct PromoteWaitlistedPlayerUseCaseTests {

    @Test
    func firstWaitlistedPlayerIsPromoted() throws {

        let repository = InMemoryWeeklyGameRegistrationRepository()

        let game = WeeklyFootballGame(
            id: UUID(),
            gameName: "Sunday Football",
            venueName: "Sydney Football Park",
            kickOffAt: Date(timeIntervalSince1970: 5_000),
            finishesAt: Date(timeIntervalSince1970: 6_000),
            playerCapacity: 1,
            registrationOpensAt: Date(timeIntervalSince1970: 1_000),
            registrationClosesAt: Date(timeIntervalSince1970: 4_000)
        )

        let firstWaitlisted = WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: UUID(),
            weeklyGameID: game.id,
            registrationStatus: .waitlisted,
            registeredAt: Date(timeIntervalSince1970: 2_000)
        )

        let secondWaitlisted = WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: UUID(),
            weeklyGameID: game.id,
            registrationStatus: .waitlisted,
            registeredAt: Date(timeIntervalSince1970: 2_100)
        )

        repository.save(firstWaitlisted)
        repository.save(secondWaitlisted)

        let useCase = PromoteWaitlistedPlayerUseCase(
            repository: repository
        )

        let promoted = try useCase.execute(game: game)

        #expect(promoted.id == firstWaitlisted.id)
        #expect(promoted.registrationStatus == .confirmed)
    }

    @Test
    func promotionFailsWhenWaitlistIsEmpty() {

        let repository = InMemoryWeeklyGameRegistrationRepository()

        let game = WeeklyFootballGame(
            id: UUID(),
            gameName: "Sunday Football",
            venueName: "Sydney Football Park",
            kickOffAt: Date(timeIntervalSince1970: 5_000),
            finishesAt: Date(timeIntervalSince1970: 6_000),
            playerCapacity: 1,
            registrationOpensAt: Date(timeIntervalSince1970: 1_000),
            registrationClosesAt: Date(timeIntervalSince1970: 4_000)
        )

        let useCase = PromoteWaitlistedPlayerUseCase(
            repository: repository
        )

        #expect(
            throws: WeeklyGameRegistrationError.waitlistEmpty
        ) {
            try useCase.execute(game: game)
        }
    }
}
