//
//  Storyboard.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

extension UIStoryboard {
    static func load<T: UIViewController>(_ storyboardName: StoryboardName) -> T {
        return UIStoryboard(name: storyboardName.rawValue, bundle: Bundle.main).instantiateInitialViewController() as! T
    }
}
