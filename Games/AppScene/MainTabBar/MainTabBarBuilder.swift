//
//  MainTabBarBuilder.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

final class MainTabBarBuilder {
    static func make() -> MainTabBarController {
        let controller = UIStoryboard.load(.mainTabBar) as! MainTabBarController
        return controller
    }
}
