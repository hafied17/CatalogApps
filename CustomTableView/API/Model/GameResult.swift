//
//  GameResult.swift
//  CustomTableView
//
//  Created by hafied Khalifatul ash.shiddiqi on 02/11/21.
//

import Foundation

struct GameResult: Codable {
    let results: [Game]
    
    enum CodingKeys: String, CodingKey {
        case results
 
    }
}
