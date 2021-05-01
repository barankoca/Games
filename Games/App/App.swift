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
    
    let container = MainContainer()
    
    func start() {
        container.router.start()
        window.makeKeyAndVisible()
    }
}
