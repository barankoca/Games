//
//  FavoritesListVC.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

final class FavoritesListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var items: [GamesListPresentation?] = []
    
    var vm: FavouritesListVMProtocol! {
        didSet {
            vm.delegate = self
        }
    }
    
    private let reuseId = "FavouritesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favourites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.getFavourites()
    }
}

extension FavoritesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            tableView.setEmptyMessage("There is no favourites found.")
        } else {
            self.tableView.restore()
        }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! FavouritesListCell
        cell.item = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Are you sure?",
                                              message: "You are about to delete favourited game. Do you want to continue?",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .destructive,
                                              handler: { [weak self] _ in
                                                guard let self = self,
                                                      let itemId = self.items[indexPath.row]?.id else { return }
                                                self.vm.removeFromFavourites(itemId)
                                                self.tableView.reloadData()
                                              }))
                alert.addAction(UIAlertAction(title: "Cancel",
                                              style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
}

extension FavoritesListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = items[indexPath.row] else { return }
        let vc = GameDetailBuilder.makeWith(item)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
}

extension FavoritesListVC: FavouritesListVMOutputDelegate {
    func updateItems(_ items: [GamesListPresentation?]) {
        DispatchQueue.main.async {
            self.items = items
            self.navigationItem.title = "Favourites(\(items.count))"
            self.tableView.reloadData()
        }
    }
}
