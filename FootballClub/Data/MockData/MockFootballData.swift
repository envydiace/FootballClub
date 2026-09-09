//
//  MockFootballData.swift
//  FootballClub
//
//  Created by Đức Anh on 8/9/26.
//

import Foundation

enum MockFootballData {

    static let weeklyGames: [WeeklyFootballGame] = [
        WeeklyFootballGame(
            id: UUID(),
            gameName: "Sunday Football",
            venueName: "Sydney Football Park",
            kickOffAt: Date().addingTimeInterval(86_400),
            finishesAt: Date().addingTimeInterval(90_000),
            playerCapacity: 20,
            registrationOpensAt: Date().addingTimeInterval(-86_400),
            registrationClosesAt: Date().addingTimeInterval(72_000)
        ),

        WeeklyFootballGame(
            id: UUID(),
            gameName: "Wednesday Night Football",
            venueName: "UTS Sports Field",
            kickOffAt: Date().addingTimeInterval(172_800),
            finishesAt: Date().addingTimeInterval(176_400),
            playerCapacity: 16,
            registrationOpensAt: Date(),
            registrationClosesAt: Date().addingTimeInterval(150_000)
        )
    ]
    
    static let members: [ClubMember] = [
        ClubMember(
            id: UUID(),
            fullName: "Alex Nguyen",
            emailAddress: "alex@example.com",
            role: .member
        ),

        ClubMember(
            id: UUID(),
            fullName: "Sarah Wilson",
            emailAddress: "sarah@example.com",
            role: .organiser
        ),

        ClubMember(
            id: UUID(),
            fullName: "Sam Lee",
            emailAddress: "sam@example.com",
            role: .member
        )
    ]
}
