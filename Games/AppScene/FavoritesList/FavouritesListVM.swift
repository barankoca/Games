//
//  FavouritesListVM.swift
//  Games
//
//  Created by Baran Koca on 6.05.2021.
//

import Foundation

final class FavouritesListVM: FavouritesListVMProtocol {
    weak var delegate: FavouritesListVMOutputDelegate?
    
    
    let favouriteManager = FavouriteManager()

    func removeFromFavourites(_ itemId: Int) {
        favouriteManager.removeFavourite(itemId)
        let items = favouriteManager.getFavourites()
        self.delegate?.updateItems(items)
    }
    
    func getFavourites() {
        let favourites = favouriteManager.getFavourites()
        self.delegate?.updateItems(favourites)
        
    }
}
