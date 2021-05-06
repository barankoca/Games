//
//  GameDetailVC.swift
//  Games
//
//  Created by Baran Koca on 3.05.2021.
//

import UIKit

final class GameDetailVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: vm.isFavourite() ? "Favourited" : "Favourite",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(favourite))
        vm.load()
    }
    
    private var item: GameDetailPresentation?
    
    private enum ReuseId: String {
        case imageCell = "GameDetailImageCell"
        case descriptionCell = "GameDetailDescriptionCell"
        case visitCell = "GameDetailVisitCell"
    }
    
    var vm: GameDetailVMProtocol! {
        didSet {
            vm.delegate = self
        }
    }
    
    @objc private func favourite() {
        if vm.isFavourite() {
            let alert = UIAlertController(title: "", message: "This game has already been favourited.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        } else {
            vm.saveFavourite() {
                DispatchQueue.main.async {
                    self.navigationItem.rightBarButtonItem?.title = self.vm.isFavourite() ? "Favourited" : "Favourite"
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension GameDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 291
        case 1: return 142
        case 2, 3: return 54
        default:
            fatalError("Unexpected cell")
        }
    }
}

extension GameDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.row {
        case 0:
            let nCell = tableView.dequeueReusableCell(withIdentifier: ReuseId.imageCell.rawValue,
                                                           for: indexPath) as! GameDetailImageCell
            nCell.item = self.item
            cell = nCell
        case 1:
            let nCell = tableView.dequeueReusableCell(withIdentifier: ReuseId.descriptionCell.rawValue,
                                                           for: indexPath) as! GameDetailDescCell
            nCell.item = self.item
            cell = nCell
        case 2:
            let nCell = tableView.dequeueReusableCell(withIdentifier: ReuseId.visitCell.rawValue,
                                                          for: indexPath) as! GameDetailVisitCell
            nCell.setLabel("Reddit")
            cell = nCell
        case 3:
            let nCell = tableView.dequeueReusableCell(withIdentifier: ReuseId.visitCell.rawValue,
                                                      for: indexPath) as! GameDetailVisitCell
            nCell.setLabel("Website")
            cell = nCell
        default: fatalError("Unexpected cell")
        }
        
        return cell
    }
}

extension GameDetailVC: GameDetailVMOutputDelegate {
    func updateItems(_ presentations: GameDetailPresentation) {
        DispatchQueue.main.async {
            self.item = presentations
            self.tableView.reloadData()
        }
    }
    
    func updateFailure() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Connection Error",
                                          message: "Please check your internet connection.",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default))
            self.present(alert, animated: true)
        }
    }
}
