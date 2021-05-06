//
//  FavouritesListContracts.swift
//  Games
//
//  Created by Baran Koca on 6.05.2021.
//

import Foundation


protocol FavouritesListVMProtocol: class {
    var delegate: FavouritesListVMOutputDelegate? { get set }
    func removeFromFavourites(_ itemId: Int)
    func getFavourites()
}

protocol FavouritesListVMOutputDelegate: class {
    func updateItems(_ items: [GamesListPresentation?])
}
