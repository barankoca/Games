//
//  FavouritesBuilder.swift
//  Games
//
//  Created by Baran Koca on 5.05.2021.
//

import UIKit

final class FavouritesListBuilder {
    static func make() -> FavoritesListVC {
        let vc = UIStoryboard.load(.favoritesList) as! FavoritesListVC
        vc.vm = FavouritesListVM()
        return vc
    }
}
