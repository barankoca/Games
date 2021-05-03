//
//  GameDetailModel.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

struct GameDetailModel: Decodable {
    let id: Int
    let name: String?
    let image: String?
    let description: String?
    let redditUrl: String?
    let website: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "background_image"
        case description = "description_raw"
        case redditUrl = "reddit_url"
        case website
    }
}
