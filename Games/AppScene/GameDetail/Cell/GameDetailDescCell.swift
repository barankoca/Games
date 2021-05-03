//
//  GameDetailDescCell.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import UIKit

final class GameDetailDescCell: UITableViewCell {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var item: GameDetailPresentation? {
        didSet {
            descriptionLabel.text = item?.description
        }
    }
}
