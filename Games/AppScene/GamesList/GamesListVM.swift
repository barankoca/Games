//
//  GamesListVM.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import Foundation

final class GamesListVM: GamesListVMProtocol {
    weak var delegate: GamesListVMOutputDelegate?
    
//    private let service = APIService()
    
    var gamePresentations = [GamesListPresentation]()
    
    func load(pageNumber: Int, searchText: String?) {
        print("Load page \(pageNumber), query \(searchText ?? "nil")")
        APIService.shared.getGames(pageNumber: pageNumber, searchText: searchText, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                self.gamePresentations = response.games.map({GamesListPresentation(model: $0)})
                self.delegate?.updateItems(self.gamePresentations, pageNumber: pageNumber)
                
            case .failure(_):
                self.delegate?.updateFailure()
            }
        })
    }
}
