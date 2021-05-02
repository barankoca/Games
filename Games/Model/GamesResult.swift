//
//  GamesResult.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import Foundation

struct GamesResult: Decodable {
    let games: [GamesData]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}

struct GamesData: Decodable {
    let id: Int
    let name: String?
    let backgroundImage: String?
    let metacritic: Int?
    let genres: [Genres]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case metacritic
        case genres
    }
}

struct Genres: Decodable {
    let name: String?
}
