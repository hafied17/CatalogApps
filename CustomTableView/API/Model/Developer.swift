//
//  Developer.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 02/11/21.
//

import Foundation

struct Developer: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain
    }
}
