//
//  WeeklyGameRegistration.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import Foundation

struct WeeklyGameRegistration: Identifiable {
    let id: UUID
    let clubMemberID: UUID
    let weeklyGameID: UUID
    var registrationStatus: WeeklyGameRegistrationStatus
    let registeredAt: Date
}
