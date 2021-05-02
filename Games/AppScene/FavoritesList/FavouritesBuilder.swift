//
//  FavouritesBuilder.swift
//  Games
//
//  Created by Baran Koca on 2.05.2021.
//

import UIKit

final class FavouritesBuilder {
    static func make() -> FavoritesListVC {
        let vc = UIStoryboard.load(.favoritesList) as! FavoritesListVC
        
        return vc
    }
}
