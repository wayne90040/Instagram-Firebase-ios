//
//  UserRelationship.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/17.
//

import Foundation

enum FollowState {
    case following, notFollowing
}

struct UserRelationship {
    let name: String
    let username: String
    let type: FollowState
}
