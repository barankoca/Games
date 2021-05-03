//
//  GameDetailImageCell.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import UIKit

final class GameDetailImageCell: UITableViewCell {
    
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    
    var item: GameDetailPresentation? {
        didSet {
            if let urlString = item?.image,
               let url = URL(string: urlString) {
                DispatchQueue.global(qos: .userInteractive).async {
                    UIImage.getImage(url: url) { [weak self] image in
                        guard let self = self else { return }
                        DispatchQueue.main.async {
                            self.gameImageView.image = image
                        }
                    }
                }
            } else {
                self.gameImageView.image = nil
            }
            
            self.gameNameLabel.text = item?.name
        }
    }
}
