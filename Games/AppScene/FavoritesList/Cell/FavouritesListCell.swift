//
//  FavouritesListCell.swift
//  Games
//
//  Created by Baran Koca on 6.05.2021.
//

import UIKit

final class FavouritesListCell: UITableViewCell {
    
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var metacriticScoreLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    
    private static let imageQueue = DispatchQueue.global(qos: .userInteractive)
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.image = nil
    }
    
    var item: GamesListPresentation! {
        didSet {
            if let urlString = item.image,
               let url = URL(string: urlString) {
                FavouritesListCell.imageQueue.async {
                    UIImage.getImage(url: url) { [weak self] image in
                        guard let self = self,
                              let currentStr = self.item.image,
                              currentStr == urlString else { return }
                        DispatchQueue.main.async {
                            self.gameImageView.image = image
                        }
                    }
                }
            } else {
                self.gameImageView.image = nil
            }
            
            gameNameLabel.text = item.name
            metacriticScoreLabel.text = "\(item.metacriticScore ?? 0)"
            genreLabel.text = item.genres.joined(separator: ",")
        }
    }
}
