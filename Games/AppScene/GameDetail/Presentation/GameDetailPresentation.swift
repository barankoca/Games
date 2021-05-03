//
//  GameDetailPresentation.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import Foundation

struct GameDetailPresentation {
    
    let model: GameDetailModel
    
    init(_ model: GameDetailModel) {
        self.model = model
    }
    
    var id: Int {
        return model.id
    }
    
    var image: String? {
        return model.image
    }
    
    var name: String {
        return model.name ?? ""
    }
    
    var description: String? {
        return model.description
    }
    
    var redditUrl: URL? {
        return URL(string: model.redditUrl ?? "")
    }
    
    var websiteUrl: URL? {
        return URL(string: model.website ?? "")
    }
    
}
