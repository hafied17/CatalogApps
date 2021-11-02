//
//  Game.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 02/11/21.
//

import Foundation

struct Game: Codable {
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        
    }
}
