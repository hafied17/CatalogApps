//
//  GameDetail.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 02/11/21.
//

import Foundation

struct GameDetail: Codable {
    let id: Int
    let slug, name, nameOriginal, welcomeDescription: String
    let released: String
    let backgroundImage, backgroundImageAdditional: String
    let website: String
    let rating: Double
    let ratingTop: Int
    let developers, genres, publishers: [Developer]

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case welcomeDescription = "description"
        case released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case developers, genres, publishers

    }
}
