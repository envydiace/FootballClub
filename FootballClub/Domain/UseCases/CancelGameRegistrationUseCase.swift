//
//  CancelGameRegistrationUseCase.swift
//  FootballClub
//
//  Created by Đức Anh on 8/9/26.
//

import Foundation

struct CancelGameRegistrationUseCase {

    private let repository: WeeklyGameRegistrationRepository

    init(repository: WeeklyGameRegistrationRepository) {
        self.repository = repository
    }

    func execute(
        member: ClubMember,
        game: WeeklyFootballGame
    ) throws -> WeeklyGameRegistration {

        guard var registration = repository.activeRegistration(
            for: member.id,
            in: game.id
        ) else {
            throw WeeklyGameRegistrationError.registrationNotFound
        }

        registration.registrationStatus = .cancelled

        repository.update(registration)

        return registration
    }
}
