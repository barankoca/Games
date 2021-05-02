//
//  ViewController.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

final class GamesListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var vm: GamesListVMProtocol = GamesListVM()
    
    private let reuseId = "GamesCell"
    
    private var pageNumber = 1
    
    private var items: [GamesListPresentation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        vm.load(pageNumber: pageNumber)
    }
}

extension GamesListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
}

extension GamesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! GamesListCell
        cell.item = items[indexPath.row]
        
        return cell
    }

    
}


extension GamesListVC: GamesListVMOutputDelegate {
    func updateItems(_ presentations: [GamesListPresentation], pageNumber: Int) {
        DispatchQueue.main.async {
            self.items = presentations
            self.tableView.reloadData()
        }
    }
}
