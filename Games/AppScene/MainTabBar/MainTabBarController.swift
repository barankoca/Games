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
        let gamesListVC = GamesListBuilder.make()
        gamesListVC.tabBarItem = UITabBarItem(title: "Games",
                                              image: UIImage(named: "ControllerIconPassive"),
                                              selectedImage: UIImage(named: "ControllerIconActive"))
        let gamesListNavigationController = UINavigationController(rootViewController: gamesListVC)
        
        let favoritesListVC = FavouritesListBuilder.make()
        favoritesListVC.tabBarItem = UITabBarItem(title: "Favourites",
                                                  image: UIImage(named: "FavouriteIconPassive"),
                                                  selectedImage: UIImage(named: "FavouriteIconActive"))
        let favouritesListNavigationController = UINavigationController(rootViewController: favoritesListVC)
        
        self.setViewControllers([gamesListNavigationController,
                                 favouritesListNavigationController], animated: false)
    }
}
