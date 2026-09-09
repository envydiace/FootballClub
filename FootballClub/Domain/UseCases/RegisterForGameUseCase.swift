//
//  RegisterForGameUseCase.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import Foundation

struct RegisterForGameUseCase {

    private let repository: WeeklyGameRegistrationRepository

    init(repository: WeeklyGameRegistrationRepository) {
        self.repository = repository
    }

    func execute(
        member: ClubMember,
        game: WeeklyFootballGame,
        currentDate: Date = Date()
    ) throws -> WeeklyGameRegistration {

        if currentDate < game.registrationOpensAt {
            throw WeeklyGameRegistrationError.registrationNotOpen
        }

        if currentDate > game.registrationClosesAt {
            throw WeeklyGameRegistrationError.registrationClosed
        }

        if repository.activeRegistration(
            for: member.id,
            in: game.id
        ) != nil {
            throw WeeklyGameRegistrationError.alreadyRegistered
        }

        let existingRegistrations = repository.registrations(for: game.id)

        let confirmedCount = existingRegistrations.filter {
            $0.registrationStatus == .confirmed
        }.count

        let status: WeeklyGameRegistrationStatus =
            confirmedCount < game.playerCapacity
            ? .confirmed
            : .waitlisted

        let registration = WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: member.id,
            weeklyGameID: game.id,
            registrationStatus: status,
            registeredAt: currentDate
        )

        repository.save(registration)

        return registration
    }
}
