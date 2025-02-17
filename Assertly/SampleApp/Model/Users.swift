//
//  Users.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 06/07/2024.
//

import Foundation

struct User: Equatable {
    let id: Int
    let name: String
}

struct UserList: Codable, Equatable {
    var totalPages: Int?
    var data: [UserListDatum]?
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case data
    }
}

struct UserListDatum: Codable,  Equatable {
    var id: Int?
    var email, firstName, lastName: String?
    var avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

