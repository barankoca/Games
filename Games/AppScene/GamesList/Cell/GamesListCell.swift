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
    
    var item: GamesListPresentation! {
        didSet {
            DispatchQueue.global().async {
                self.getImage(imageString: self.item.image) { (image) in
                    DispatchQueue.main.async { [weak self] in
                        self?.gameImageView.image = image
                    }
                }
            }
            gameNameLabel.text = item.name
            metacriticScoreLabel.text = "\(item.metacriticScore ?? 0)"
        }
    }
    
    private func getImage(imageString: String?,
                          completion: @escaping (UIImage?) -> Void) {
        guard let imageString = imageString,
              let url = URL(string: imageString) else { return }
        do {
            let data = try Data(contentsOf: url)
            completion(UIImage(data: data))
        } catch {
            print(error)
            completion(nil)
        }
    }
}
