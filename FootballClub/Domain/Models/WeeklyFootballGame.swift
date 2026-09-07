//
//  WeeklyFootballGame.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import Foundation

struct WeeklyFootballGame: Identifiable {
    let id: UUID
    let gameName: String
    let venueName: String
    let kickOffAt: Date
    let finishesAt: Date
    let playerCapacity: Int
    let registrationOpensAt: Date
    let registrationClosesAt: Date
}
