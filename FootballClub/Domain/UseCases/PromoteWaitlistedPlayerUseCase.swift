//
//  PromoteWaitlistedPlayerUseCase.swift
//  FootballClub
//
//  Created by Đức Anh on 8/9/26.
//

import Foundation

struct PromoteWaitlistedPlayerUseCase {

    private let repository: WeeklyGameRegistrationRepository

    init(repository: WeeklyGameRegistrationRepository) {
        self.repository = repository
    }

    func execute(
        game: WeeklyFootballGame
    ) throws -> WeeklyGameRegistration {

        guard var registration =
                repository.firstWaitlistedRegistration(
                    for: game.id
                )
        else {
            throw WeeklyGameRegistrationError.waitlistEmpty
        }

        registration.registrationStatus = .confirmed

        repository.update(registration)

        return registration
    }
}
