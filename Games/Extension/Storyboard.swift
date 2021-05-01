//
//  Storyboard.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

extension UIStoryboard {
    static func load<T: UIViewController>(_ name: StoryboardName) -> T {
        
        return UIStoryboard(name: name.rawValue,
                            bundle: Bundle.main).instantiateInitialViewController() as! T
    }
}
