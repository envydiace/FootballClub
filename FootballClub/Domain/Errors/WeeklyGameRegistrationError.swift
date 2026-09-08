//
//  WeeklyGameRegistrationError.swift
//  FootballClub
//
//  Created by Đức Anh on 7/9/26.
//

import Foundation

enum WeeklyGameRegistrationError: LocalizedError, Equatable {
    case registrationNotOpen
    case registrationClosed
    case alreadyRegistered
    case memberNotFound
    case gameNotFound

    var errorDescription: String? {
        switch self {
        case .registrationNotOpen:
            return "Registration for this game has not opened yet."

        case .registrationClosed:
            return "Registration for this game is already closed."

        case .alreadyRegistered:
            return "You are already registered for this game."

        case .memberNotFound:
            return "The club member could not be found."

        case .gameNotFound:
            return "The weekly football game could not be found."
        }
    }
}
