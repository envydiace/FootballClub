//
//  ManageGameViewModel.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation
import Observation

@Observable
final class ManageGameViewModel {

    var confirmedPlayers: [RegistrationMemberDisplayItem] = []
    var waitlistedPlayers: [RegistrationMemberDisplayItem] = []
    var message: String?

    private let repository: WeeklyGameRegistrationRepository
    private let memberRepository: ClubMemberRepository
    private let promoteWaitlistedPlayerUseCase: PromoteWaitlistedPlayerUseCase

    init(
        registrationRepository: WeeklyGameRegistrationRepository,
        memberRepository: ClubMemberRepository
    ) {
        self.repository = registrationRepository
        self.memberRepository = memberRepository

        self.promoteWaitlistedPlayerUseCase =
            PromoteWaitlistedPlayerUseCase(
                repository: registrationRepository
            )
    }

    func loadRegistrations(
        for game: WeeklyFootballGame
    ) {

        let registrations =
            repository.registrations(
                for: game.id
            )

        confirmedPlayers = registrations
            .filter {
                $0.registrationStatus == .confirmed
            }
            .compactMap { registration in

                guard let member =
                        memberRepository.member(
                            withID: registration.clubMemberID
                        )
                else {
                    return nil
                }

                return RegistrationMemberDisplayItem(
                    registration: registration,
                    member: member
                )
            }

        waitlistedPlayers = registrations
            .filter {
                $0.registrationStatus == .waitlisted
            }
            .sorted {
                $0.registeredAt < $1.registeredAt
            }
            .compactMap { registration in

                guard let member =
                        memberRepository.member(
                            withID: registration.clubMemberID
                        )
                else {
                    return nil
                }

                return RegistrationMemberDisplayItem(
                    registration: registration,
                    member: member
                )
            }
    }

    func promoteFirstWaitlistedPlayer(
        for game: WeeklyFootballGame
    ) {
        do {
            _ = try promoteWaitlistedPlayerUseCase.execute(
                game: game
            )

            message = "Waitlisted player promoted successfully."

            loadRegistrations(for: game)

        } catch {
            message = error.localizedDescription
        }
    }
}
