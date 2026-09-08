//
//  WeeklyGameRegistrationRepository.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import Foundation

protocol WeeklyGameRegistrationRepository {

    func registrations(
        for weeklyGameID: UUID
    ) -> [WeeklyGameRegistration]

    func registration(
        for clubMemberID: UUID,
        in weeklyGameID: UUID
    ) -> WeeklyGameRegistration?

    func save(_ registration: WeeklyGameRegistration)

    func update(_ registration: WeeklyGameRegistration)
}
