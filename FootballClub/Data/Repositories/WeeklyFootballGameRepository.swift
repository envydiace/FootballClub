//
//  WeeklyFootballGameRepository.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation

protocol WeeklyFootballGameRepository {
    func allGames() -> [WeeklyFootballGame]

    func game(
        withID weeklyGameID: UUID
    ) -> WeeklyFootballGame?
}
