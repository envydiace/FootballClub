//
//  RegistrationDisplayItem.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation

struct RegistrationDisplayItem: Identifiable {
    let registration: WeeklyGameRegistration
    let game: WeeklyFootballGame

    var id: UUID {
        registration.id
    }
}
