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

    func activeRegistration(
        for clubMemberID: UUID,
        in weeklyGameID: UUID
    ) -> WeeklyGameRegistration?
    
    func registrationIncludingCancelled(
        for clubMemberID: UUID,
        in weeklyGameID: UUID
    ) -> WeeklyGameRegistration?
    
    func firstWaitlistedRegistration(
        for weeklyGameID: UUID
    ) -> WeeklyGameRegistration?
    
    func registrationsForMember(
        _ clubMemberID: UUID
    ) -> [WeeklyGameRegistration]

    func save(_ registration: WeeklyGameRegistration)

    func update(_ registration: WeeklyGameRegistration)
}
