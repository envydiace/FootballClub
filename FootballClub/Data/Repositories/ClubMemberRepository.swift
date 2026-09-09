//
//  ClubMemberRepository.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation

protocol ClubMemberRepository {
    func member(
        withID clubMemberID: UUID
    ) -> ClubMember?
}
