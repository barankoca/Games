//
//  GamesListContracts.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import Foundation

protocol GamesListVMProtocol: class {
    var delegate: GamesListVMOutputDelegate? { get set }
    func load(pageNumber: Int)
}

protocol GamesListVMOutputDelegate: class {
    func updateItems(_ presentations: [GamesListPresentation], pageNumber: Int)
}
