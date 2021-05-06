//
//  GameDetailVM.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import Foundation

final class GameDetailVM: GameDetailVMProtocol {
    weak var delegate: GameDetailVMOutputDelegate?
    
    private let item: GamesListPresentation
    
    private let favouriteManager = FavouriteManager()
    
    init(_ item: GamesListPresentation) {
        self.item = item
    }
    
    func load() {
        APIService.shared.getDetail(id: item.id) {(result) in
            switch result {
            case let .success(response):
                let presentation = GameDetailPresentation(response)
                self.delegate?.updateItems(presentation)
            case .failure(_):
                self.delegate?.updateFailure()
            }
        }
    }
    
    func isFavourite() -> Bool {
        return favouriteManager.isFavourite(item.id)
    }
    
    func saveFavourite(completion: @escaping () -> Void) {
        favouriteManager.appendNewFavorurites(item)
        completion()
    }
}
