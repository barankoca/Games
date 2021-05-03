//
//  GameDetailContracts.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import Foundation


protocol GameDetailVMProtocol: class {
    var delegate: GameDetailVMOutputDelegate? { get set }
    func load()
}

protocol GameDetailVMOutputDelegate: class {
    func updateItems(_ presentations: GameDetailPresentation)
    func updateFailure()
}
