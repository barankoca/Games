//
//  GameDetailBuilder.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import UIKit

final class GameDetailBuilder {
    static func makeWith(_ id: Int) -> GameDetailVC {
        let vc = UIStoryboard.load(.gameDetail) as! GameDetailVC
        vc.vm = GameDetailVM(id)
        return vc
    }
}
