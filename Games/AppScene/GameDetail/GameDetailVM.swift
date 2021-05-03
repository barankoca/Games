//
//  GameDetailVM.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import Foundation

final class GameDetailVM: GameDetailVMProtocol {
    weak var delegate: GameDetailVMOutputDelegate?
    
    private let id: Int
    
    private let service = APIService()
    
    init(_ id: Int) {
        self.id = id
    }
    
    func load() {
        service.getDetail(id: self.id) {(result) in
            
            switch result {
            case let .success(response):
                let presentation = GameDetailPresentation(response)
                self.delegate?.updateItems(presentation)
            case .failure(_):
                self.delegate?.updateFailure()
            }
        }
    }
    

    
}
