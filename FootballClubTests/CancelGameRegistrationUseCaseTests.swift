//
//  CancelGameRegistrationUseCaseTests.swift
//  FootballClub
//
//  Created by Đức Anh on 8/9/26.
//

import Testing
import Foundation
@testable import FootballClub

struct CancelGameRegistrationUseCaseTests {

    @Test
    func activeRegistrationCanBeCancelled() throws {

        let repository = InMemoryWeeklyGameRegistrationRepository()

        let member = ClubMember(
            id: UUID(),
            fullName: "Alex Nguyen",
            emailAddress: "alex@example.com",
            role: .member
        )

        let game = WeeklyFootballGame(
            id: UUID(),
            gameName: "Sunday Football",
            venueName: "Sydney Football Park",
            kickOffAt: Date(timeIntervalSince1970: 5_000),
            finishesAt: Date(timeIntervalSince1970: 6_000),
            playerCapacity: 20,
            registrationOpensAt: Date(timeIntervalSince1970: 1_000),
            registrationClosesAt: Date(timeIntervalSince1970: 4_000)
        )

        let registration = WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: member.id,
            weeklyGameID: game.id,
            registrationStatus: .confirmed,
            registeredAt: Date(timeIntervalSince1970: 2_000)
        )

        repository.save(registration)

        let useCase = CancelGameRegistrationUseCase(
            repository: repository
        )

        let cancelledRegistration = try useCase.execute(
            member: member,
            game: game
        )

        #expect(
            cancelledRegistration.registrationStatus == .cancelled
        )
    }
    
    @Test
    func cancellingWithoutRegistrationThrowsError() {

        let repository = InMemoryWeeklyGameRegistrationRepository()

        let member = ClubMember(
            id: UUID(),
            fullName: "Alex Nguyen",
            emailAddress: "alex@example.com",
            role: .member
        )

        let game = WeeklyFootballGame(
            id: UUID(),
            gameName: "Sunday Football",
            venueName: "Sydney Football Park",
            kickOffAt: Date(timeIntervalSince1970: 5_000),
            finishesAt: Date(timeIntervalSince1970: 6_000),
            playerCapacity: 20,
            registrationOpensAt: Date(timeIntervalSince1970: 1_000),
            registrationClosesAt: Date(timeIntervalSince1970: 4_000)
        )

        let useCase = CancelGameRegistrationUseCase(
            repository: repository
        )

        #expect(
            throws: WeeklyGameRegistrationError.registrationNotFound
        ) {
            try useCase.execute(
                member: member,
                game: game
            )
        }
    }
}
