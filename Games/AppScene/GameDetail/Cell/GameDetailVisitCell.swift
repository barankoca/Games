//
//  GameDetailVisitCell.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import UIKit

final class GameDetailVisitCell: UITableViewCell {
    
    @IBOutlet private weak var websiteLabel: UILabel!
    
    func setLabel(_ website: String) {
        websiteLabel.text = "Visit \(website)"
    }
    
}
