//
//  Models.swift
//  Instagram
//
//  Created by Duy Nguyễn on 29/12/2022.
//

import Foundation

enum Gender {
    case male, female, other
}

struct User {
    let usernam: String
    let bio: String
    let name: (first: String,last: String)
    let profilePhoto: URL
    let birthDate: Data
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}
struct UserCount {
    let followers: Int
    let following: Int
    let poster: Int
}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
    let thumbnailImage: URL
    let postURl: URL //either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUser: [String]
}

struct PostLikes {
    let username: String
    let postIdentifier: String
}

struct CommentLikes {
    let username: String
    let commentdentifier: String
}

struct PostComment {
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLikes]
}
