//
//  GamesListPresentation.swift
//  Games
//
//  Created by Baran Koca on 2.05.2021.
//

import UIKit

struct GamesListPresentation {
    var model: GamesData
    
    init(model: GamesData) {
        self.model = model
    }
    
    var id: Int {
        return model.id
    }
    
    var image: String? {
        return model.backgroundImage
//        DispatchQueue.global().async{
//            guard let imageString = model.backgroundImage,
//                  let url = URL(string: imageString),
//                  let data = try? Data(contentsOf: url) else { return nil }
//            return UIImage(data: data)
//        }
    }
    
    var name: String? {
        return model.name ?? nil
    }
    
    var metacriticScore: Int? {
        return model.metacritic ?? nil
    }
}
