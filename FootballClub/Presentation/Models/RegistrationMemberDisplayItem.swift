//
//  RegistrationMemberDisplayItem.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation

struct RegistrationMemberDisplayItem: Identifiable {
    let registration: WeeklyGameRegistration
    let member: ClubMember

    var id: UUID {
        registration.id
    }
}
