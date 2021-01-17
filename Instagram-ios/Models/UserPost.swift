//
//  PostMediaType.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/14.
//

import Foundation

enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthday: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

enum PostMediaType {
    case photo, video
}

/// user post
struct UserPost {
    let identifier: String
    let postMediaType: PostMediaType
    let thumbnailImage: URL
    let postUrl: URL
    let caption: String?
    let likeCount: [UserLike]
    let comments: [PostComment]
    let postDate: Date
    let taggedUser: [User]
}

struct UserLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let postIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLike]
}
