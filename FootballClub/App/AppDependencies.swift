//
//  AppDependencies.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation

final class AppDependencies {

    let registrationRepository: InMemoryWeeklyGameRegistrationRepository

    let currentMember: ClubMember

    init() {
        self.registrationRepository =
            InMemoryWeeklyGameRegistrationRepository()

        self.currentMember = ClubMember(
            id: UUID(),
            fullName: "Alex Nguyen",
            emailAddress: "alex@example.com"
        )
    }
}
