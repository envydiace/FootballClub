//
//  MockFootballData.swift
//  FootballClub
//
//  Created by Đức Anh on 8/9/26.
//

import Foundation

enum MockFootballData {

    static let weeklyGames: [WeeklyFootballGame] = [

        // Game 1 - Full, Sam confirmed, Alex waitlisted
        WeeklyFootballGame(
            id: UUID(),
            gameName: "Sunday Football",
            venueName: "Sydney Football Park",
            kickOffAt: Date().addingTimeInterval(86_400),
            finishesAt: Date().addingTimeInterval(90_000),
            playerCapacity: 1,
            registrationOpensAt: Date().addingTimeInterval(-86_400),
            registrationClosesAt: Date().addingTimeInterval(72_000)
        ),

        // Game 2 - Open, available spots
        WeeklyFootballGame(
            id: UUID(),
            gameName: "Wednesday Night Football",
            venueName: "UTS Sports Field",
            kickOffAt: Date().addingTimeInterval(172_800),
            finishesAt: Date().addingTimeInterval(176_400),
            playerCapacity: 16,
            registrationOpensAt: Date().addingTimeInterval(-43_200),
            registrationClosesAt: Date().addingTimeInterval(150_000)
        ),

        // Game 3 - Registration not open yet
        WeeklyFootballGame(
            id: UUID(),
            gameName: "Friday Evening Football",
            venueName: "Moore Park Synthetic Field",
            kickOffAt: Date().addingTimeInterval(259_200),
            finishesAt: Date().addingTimeInterval(262_800),
            playerCapacity: 20,
            registrationOpensAt: Date().addingTimeInterval(86_400),
            registrationClosesAt: Date().addingTimeInterval(240_000)
        ),

        // Game 4 - Registration already closed
        WeeklyFootballGame(
            id: UUID(),
            gameName: "Saturday Morning Football",
            venueName: "Centennial Park",
            kickOffAt: Date().addingTimeInterval(43_200),
            finishesAt: Date().addingTimeInterval(46_800),
            playerCapacity: 12,
            registrationOpensAt: Date().addingTimeInterval(-172_800),
            registrationClosesAt: Date().addingTimeInterval(-3_600)
        ),

        // Game 5 - Open, nearly full
        WeeklyFootballGame(
            id: UUID(),
            gameName: "Tuesday Social Football",
            venueName: "Perry Park",
            kickOffAt: Date().addingTimeInterval(345_600),
            finishesAt: Date().addingTimeInterval(349_200),
            playerCapacity: 3,
            registrationOpensAt: Date().addingTimeInterval(-86_400),
            registrationClosesAt: Date().addingTimeInterval(330_000)
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
        ),

        ClubMember(
            id: UUID(),
            fullName: "Jordan Smith",
            emailAddress: "jordan@example.com",
            role: .member
        ),

        ClubMember(
            id: UUID(),
            fullName: "Chris Brown",
            emailAddress: "chris@example.com",
            role: .member
        )
    ]

    static let registrations: [WeeklyGameRegistration] = [

        // Alex waitlisted for Sunday Football
        WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: members[0].id,
            weeklyGameID: weeklyGames[0].id,
            registrationStatus: .waitlisted,
            registeredAt: Date().addingTimeInterval(-3_600)
        ),

        // Sam confirmed for Sunday Football
        WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: members[2].id,
            weeklyGameID: weeklyGames[0].id,
            registrationStatus: .confirmed,
            registeredAt: Date().addingTimeInterval(-1_800)
        ),

        // Alex confirmed for Wednesday Night Football
        WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: members[0].id,
            weeklyGameID: weeklyGames[1].id,
            registrationStatus: .confirmed,
            registeredAt: Date().addingTimeInterval(-7_200)
        ),

        // Jordan confirmed for Wednesday Night Football
        WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: members[3].id,
            weeklyGameID: weeklyGames[1].id,
            registrationStatus: .confirmed,
            registeredAt: Date().addingTimeInterval(-5_400)
        ),

        // Alex previously cancelled Saturday Morning Football
        WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: members[0].id,
            weeklyGameID: weeklyGames[3].id,
            registrationStatus: .cancelled,
            registeredAt: Date().addingTimeInterval(-86_400)
        ),

        // Sarah confirmed for Tuesday Social Football
        WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: members[1].id,
            weeklyGameID: weeklyGames[4].id,
            registrationStatus: .confirmed,
            registeredAt: Date().addingTimeInterval(-10_800)
        ),

        // Sam confirmed for Tuesday Social Football
        WeeklyGameRegistration(
            id: UUID(),
            clubMemberID: members[2].id,
            weeklyGameID: weeklyGames[4].id,
            registrationStatus: .confirmed,
            registeredAt: Date().addingTimeInterval(-7_200)
        )
    ]
}
