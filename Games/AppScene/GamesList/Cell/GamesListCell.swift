//
//  GamesListCell.swift
//  Games
//
//  Created by Baran Koca on 2.05.2021.
//

import UIKit

final class GamesListCell: UITableViewCell {
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
            if let urlString = item.image {
                GamesListCell.imageQueue.async {
                    APIService.shared.downloadImageWith(urlString: urlString) { [weak self] (imageData, error) in
                        guard let self = self,
                              let imageData = imageData,
                              let currentStr = self.item?.image,
                              currentStr == urlString,
                              let gameImage = UIImage(data: imageData) else { return }
                        DispatchQueue.main.async {
                            self.gameImageView.image = gameImage
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
