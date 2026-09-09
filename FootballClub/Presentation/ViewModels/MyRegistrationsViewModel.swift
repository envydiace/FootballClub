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

    var registrations: [WeeklyGameRegistration] = []

    private let repository: WeeklyGameRegistrationRepository
    private let currentMember: ClubMember

    init(
        repository: WeeklyGameRegistrationRepository,
        currentMember: ClubMember
    ) {
        self.repository = repository
        self.currentMember = currentMember
    }

    func loadRegistrations() {
        registrations = repository
            .registrationsForMember(currentMember.id)
            .filter {
                $0.registrationStatus != .cancelled
            }
    }
}
