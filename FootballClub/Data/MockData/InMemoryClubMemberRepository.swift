//
//  InMemoryClubMemberRepository.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation

final class InMemoryClubMemberRepository: ClubMemberRepository {

    private let storedMembers: [ClubMember]

    init(members: [ClubMember]) {
        self.storedMembers = members
    }

    func member(
        withID clubMemberID: UUID
    ) -> ClubMember? {
        storedMembers.first {
            $0.id == clubMemberID
        }
    }
}
