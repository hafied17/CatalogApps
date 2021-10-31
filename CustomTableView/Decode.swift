//
//  Decode.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 29/10/21.
//

import Foundation

struct Welcome: Codable {
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case results
 
    }
}

// MARK: - Result
struct Result: Codable {
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
// MARK: - Welcome
struct Detail: Codable {
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


// MARK: - Developer
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

// MARK: - Store
struct Store: Codable {
    let id: Int
    let url: String
    let store: Developer
}
