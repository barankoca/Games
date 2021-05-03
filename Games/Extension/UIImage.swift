//
//  UIImage.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import UIKit

extension UIImage {
    static func getImage(url: URL,
                         completion: @escaping (UIImage?) -> Void) {
        do {
            let data = try Data(contentsOf: url)
            completion(UIImage(data: data))
        } catch {
            print(error)
            completion(nil)
        }
    }
}
