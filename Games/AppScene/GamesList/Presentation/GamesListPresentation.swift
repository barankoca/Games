//
//  GamesListPresentation.swift
//  Games
//
//  Created by Baran Koca on 2.05.2021.
//

import UIKit

struct GamesListPresentation: Codable {
    var model: GamesData
    
    init(model: GamesData) {
        self.model = model
    }
    
    var id: Int {
        return model.id
    }
    
    var image: String? {
        return model.backgroundImage
    }
    
    var name: String? {
        return model.name ?? nil
    }
    
    var metacriticScore: Int? {
        return model.metacritic ?? nil
    }
    
    var genres: [String] {
        let genreNames: [String] = model.genres.map({ ($0.name) })
        return genreNames
    }
}
