//
//  App.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

let app = App()

final class App {
    
    let window: UIWindow = {
       let window = UIWindow()
        return window
    }()
    
    func start() {
        let vc = MainTabBarBuilder.make()
        app.window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
