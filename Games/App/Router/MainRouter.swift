//
//  MainRouter.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

final class MainRouter {
    private let navigationController = UINavigationController()
    
    func start() {
        let vc = MainTabBarBuilder.make()
        navigationController.pushViewController(vc, animated: true)
        navigationController.navigationBar.prefersLargeTitles = true
        app.window.rootViewController = navigationController
    }
}
