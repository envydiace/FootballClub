//
//  InMemoryWeeklyGameRegistrationRepository.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import Foundation

final class InMemoryWeeklyGameRegistrationRepository: WeeklyGameRegistrationRepository {

    private var storedRegistrations: [WeeklyGameRegistration] = []

    func registrations(
        for weeklyGameID: UUID
    ) -> [WeeklyGameRegistration] {

        storedRegistrations.filter {
            $0.weeklyGameID == weeklyGameID
        }
    }

    func registration(
        for clubMemberID: UUID,
        in weeklyGameID: UUID
    ) -> WeeklyGameRegistration? {

        storedRegistrations.first {
            $0.clubMemberID == clubMemberID &&
            $0.weeklyGameID == weeklyGameID &&
            $0.registrationStatus != .cancelled
        }
    }

    func save(_ registration: WeeklyGameRegistration) {
        storedRegistrations.append(registration)
    }
}
