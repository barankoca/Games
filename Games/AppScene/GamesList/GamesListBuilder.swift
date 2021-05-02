//
//  GamesListBuilder.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

final class GamesListBuilder {
    static func make() -> GamesListVC {
        let vc = UIStoryboard.load(.gamesList) as! GamesListVC
        vc.vm = GamesListVM()
        
        return vc
    }
}
