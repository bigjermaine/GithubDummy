//
//  RespositioryModel.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//

import Foundation

import Foundation

struct Repository: Codable {
    let id: Int
    let nodeId: String?
    let name: String
    let fullName: String?
    let isPrivate: Bool?
    let owner: Owner?
    let htmlUrl: String?
    let description: String?
    let fork: Bool?
    let url: String?


    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlUrl = "html_url"
        case description
        case fork
        case url


    }
}

struct Owner: Codable {
    let login: String?
    let id: Int?
    let nodeId: String?
    let avatarUrl: String?
    let url: String?
    let htmlUrl: String?

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case url
        case htmlUrl = "html_url"
    }
}
