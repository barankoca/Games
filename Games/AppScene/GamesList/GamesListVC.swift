//
//  ViewController.swift
//  Games
//
//  Created by Baran Koca on 1.05.2021.
//

import UIKit

final class GamesListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    var vm: GamesListVMProtocol = GamesListVM()
    
    private let reuseId = "GamesCell"

    
    private var pageNumber: Int = 1
    private var limit: Int = 10
    private var isLoading: Bool = false {
        didSet {
            isLoading ? indicator.startAnimating() : indicator.stopAnimating()
        }
    }
    
    private var items: [GamesListPresentation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "GAMES"
        vm.load(pageNumber: pageNumber)
    }
    
    private func loadMore(pageNumber: Int) {
        isLoading = true
        vm.load(pageNumber: pageNumber)
    }
}

extension GamesListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isLoading,
           indexPath.row == items.count - 1 {
            pageNumber += 1
            self.loadMore(pageNumber: pageNumber)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let itemId = items[indexPath.row].id
        let vc = GameDetailBuilder.makeWith(itemId)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
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
    func updateFailure() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Connection Error", message: "Please check your connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.isLoading = false
            self.present(alert, animated: true)
        }
    }
    
    func updateItems(_ presentations: [GamesListPresentation], pageNumber: Int) {
        DispatchQueue.main.async {
            self.items.append(contentsOf: presentations)
            self.tableView.reloadData()
            
            self.isLoading = false
        }
    }
}
