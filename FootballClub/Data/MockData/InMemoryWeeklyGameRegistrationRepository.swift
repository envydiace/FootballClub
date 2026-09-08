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
    
    func firstWaitlistedRegistration(
        for weeklyGameID: UUID
    ) -> WeeklyGameRegistration? {

        storedRegistrations
            .filter {
                $0.weeklyGameID == weeklyGameID &&
                $0.registrationStatus == .waitlisted
            }
            .sorted {
                $0.registeredAt < $1.registeredAt
            }
            .first
    }

    func save(_ registration: WeeklyGameRegistration) {
        storedRegistrations.append(registration)
    }
    
    func update(_ registration: WeeklyGameRegistration) {
        guard let index = storedRegistrations.firstIndex(
            where: { $0.id == registration.id }
        ) else {
            return
        }

        storedRegistrations[index] = registration
    }
}
