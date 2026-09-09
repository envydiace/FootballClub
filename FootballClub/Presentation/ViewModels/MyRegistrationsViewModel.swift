//
//  MyRegistrationsViewModel.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation
import Observation

@Observable
final class MyRegistrationsViewModel {

    var items: [RegistrationDisplayItem] = []

    private let registrationRepository:
        WeeklyGameRegistrationRepository

    private let gameRepository:
        WeeklyFootballGameRepository

    private let currentMember: ClubMember

    init(
        registrationRepository: WeeklyGameRegistrationRepository,
        gameRepository: WeeklyFootballGameRepository,
        currentMember: ClubMember
    ) {
        self.registrationRepository = registrationRepository
        self.gameRepository = gameRepository
        self.currentMember = currentMember
    }

    func loadRegistrations() {

        let registrations =
            registrationRepository
                .registrationsForMember(
                    currentMember.id
                )
                .filter {
                    $0.registrationStatus != .cancelled
                }

        items = registrations.compactMap { registration in

            guard let game =
                    gameRepository.game(
                        withID: registration.weeklyGameID
                    )
            else {
                return nil
            }

            return RegistrationDisplayItem(
                registration: registration,
                game: game
            )
        }
    }
}
