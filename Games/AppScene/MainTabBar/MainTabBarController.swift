//
//  MainTabBarController.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabs()
    }
    
    private func loadTabs() {
        let gamesListVC = UIStoryboard.load(.gamesList)
        let favoritesListVC = UIStoryboard.load(.favoritesList)
        
        self.setViewControllers([gamesListVC,
                                 favoritesListVC], animated: false)
    }
}
