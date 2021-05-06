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
            if let urlString = item?.image {
                DispatchQueue.global(qos: .userInteractive).async {
                    APIService.shared.downloadImageWith(urlString: urlString) { [weak self] (imageData, error) in
                        guard let self = self,
                              let currentStr = self.item?.image,
                              currentStr == urlString,
                              let imageData = imageData,
                              let gameImage = UIImage(data: imageData) else { return }
                        DispatchQueue.main.async {
                            self.gameImageView.image = gameImage
                        }
                    }
                }
            } else {
                self.gameImageView.image = UIImage(named: "Placeholder")
            }
            
            self.gameNameLabel.text = item?.name
        }
    }
}
