//
//  GameDetailBuilder.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import UIKit

final class GameDetailBuilder {
    static func makeWith(_ item: GamesListPresentation) -> GameDetailVC {
        let vc = UIStoryboard.load(.gameDetail) as! GameDetailVC
        vc.vm = GameDetailVM(item)
        return vc
    }
}
