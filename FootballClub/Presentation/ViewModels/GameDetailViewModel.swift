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

    var currentRegistration: WeeklyGameRegistration?
    var errorMessage: String?

    private let repository: WeeklyGameRegistrationRepository
    private let registerForGameUseCase: RegisterForGameUseCase
    private let currentMember: ClubMember

    init(
        repository: WeeklyGameRegistrationRepository,
        currentMember: ClubMember
    ) {
        self.repository = repository
        self.currentMember = currentMember

        self.registerForGameUseCase =
            RegisterForGameUseCase(
                repository: repository
            )
    }

    func loadCurrentRegistration(
        for game: WeeklyFootballGame
    ) {
        currentRegistration = repository.registrationIncludingCancelled(
            for: currentMember.id,
            in: game.id
        )

        errorMessage = nil
    }

    func register(
        for game: WeeklyFootballGame
    ) {
        do {
            currentRegistration =
                try registerForGameUseCase.execute(
                    member: currentMember,
                    game: game
                )

            errorMessage = nil

        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
