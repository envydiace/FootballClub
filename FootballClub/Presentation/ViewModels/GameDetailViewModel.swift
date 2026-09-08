//
//  GameDetailViewModel.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation
import Observation

@Observable
final class GameDetailViewModel {

    var registrationMessage: String?
    var registrationSucceeded = false

    private let registerForGameUseCase:
        RegisterForGameUseCase

    private let currentMember: ClubMember

    init(
        repository: WeeklyGameRegistrationRepository,
        currentMember: ClubMember
    ) {
        self.registerForGameUseCase =
            RegisterForGameUseCase(
                repository: repository
            )

        self.currentMember = currentMember
    }

    func register(
        for game: WeeklyFootballGame
    ) {
        do {
            let registration =
                try registerForGameUseCase.execute(
                    member: currentMember,
                    game: game
                )

            registrationSucceeded = true

            switch registration.registrationStatus {
            case .confirmed:
                registrationMessage =
                    "You are confirmed for this game."

            case .waitlisted:
                registrationMessage =
                    "The game is full. You have been added to the waitlist."

            case .cancelled:
                registrationMessage =
                    "Registration cancelled."
            }

        } catch {
            registrationSucceeded = false
            registrationMessage =
                error.localizedDescription
        }
    }
}
