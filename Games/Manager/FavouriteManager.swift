//
//  FavouriteManager.swift
//  Games
//
//  Created by Baran Koca on 4.05.2021.
//

import Foundation

final class FavouriteManager {
    
    private let userDefaults = UserDefaults.standard
    
    func saveFavourites(_ items: [GamesListPresentation?]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            userDefaults.set(encoded, forKey: "SavedGames")
        }
    }
    
    func getFavourites() -> [GamesListPresentation?] {
        var favourites: [GamesListPresentation?] = []
        if let savedGame = userDefaults.object(forKey: "SavedGames") as? Data {
            let decoder = JSONDecoder()
            guard let favor = try? decoder.decode([GamesListPresentation].self, from: savedGame) else {
                return []
            }
            favourites = favor
        }
        return favourites
    }
    
    func isFavourite(_ itemId: Int) -> Bool {
        let favouriteId = getFavourites().compactMap({ $0?.id })
        return favouriteId.contains(itemId)
    }
    
    func removeFavourite(_ itemId: Int) {
        guard isFavourite(itemId) else { return }
        
        var favourites = getFavourites()
        favourites.removeAll(where: {$0?.id == itemId})
        
        saveFavourites(favourites)
    }
}
