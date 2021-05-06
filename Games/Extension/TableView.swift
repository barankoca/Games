//
//  TableView.swift
//  Games
//
//  Created by Baran Koca on 5.05.2021.
//

import UIKit

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyLabel.text = message
        if #available(iOS 12.0, *) {
            emptyLabel.textColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
        } else {
            emptyLabel.textColor = .black
        }
        emptyLabel.textColor = .white
        emptyLabel.numberOfLines = 0
        emptyLabel.textAlignment = .center
        emptyLabel.sizeToFit()

        self.backgroundView = emptyLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
