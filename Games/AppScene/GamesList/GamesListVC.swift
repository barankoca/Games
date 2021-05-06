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
    
    var vm: GamesListVMProtocol! {
        didSet {
            vm.delegate = self
        }
    }
    
    private let reuseId = "GamesCell"

    
    private var pageNumber: Int = 1
    private var searchText: String?
    private var isLoading: Bool = false {
        didSet {
            isLoading ? indicator.startAnimating() : indicator.stopAnimating()
        }
    }
    
    private var items: [GamesListPresentation] = []
    
    private var timer: Timer?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        self.navigationItem.title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        vm.load(pageNumber: pageNumber, searchText: nil)
    }
    
    private func loadMore(pageNumber: Int,
                          searchText: String?) {
        isLoading = true
        vm.load(pageNumber: self.pageNumber,
                searchText: self.searchText)
    }
    
    private func setTimer() {
        DispatchQueue.main.async {
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 5,
                                         target: self,
                                         selector: #selector(self.loadWithTimer(_:)),
                                         userInfo: nil,
                                         repeats: false)
        }
    }
    
    @objc private func loadWithTimer(_ sender: Timer) {
        vm.load(pageNumber: pageNumber, searchText: searchText)
    }
}

extension GamesListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("items \(items.count) index \(indexPath.row)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if indexPath.row == self.items.count - 1,
               tableView.visibleCells.contains(cell),
               !self.isLoading {
                self.pageNumber += 1
                self.loadMore(pageNumber: self.pageNumber, searchText: self.searchText)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        let vc = GameDetailBuilder.makeWith(item)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
}

extension GamesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            self.tableView.setEmptyMessage("No game has been searched.")
        } else {
            self.tableView.restore()
        }
        
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

extension GamesListVC: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.items = []
        if searchText.count >= 3 {
            self.isLoading = true
            let trimmedString = searchText.trimmingCharacters(in: .whitespaces)
            self.searchText = trimmedString
            self.pageNumber = 1
            setTimer()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = nil
        self.items = []
        self.pageNumber = 1
        vm.load(pageNumber: self.pageNumber, searchText: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        items = []
        tableView.reloadData()
    }
}
