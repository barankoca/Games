//
//  GamesListVM.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import Foundation

final class GamesListVM: GamesListVMProtocol {
    weak var delegate: GamesListVMOutputDelegate?
    
    private let service = APIService()
    
    var gamePresentations = [GamesListPresentation]()
    
    func load(pageNumber: Int) {
        service.getGames(completion: { [weak self] (games, error) in
            guard let self = self else { return }
            
            self.gamePresentations = games.map({GamesListPresentation(model: $0)})
            
            self.delegate?.updateItems(self.gamePresentations, pageNumber: pageNumber)
            
        })
    }
    
    
    
    
}
