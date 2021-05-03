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
    private var searchText: String?
    private var isLoading: Bool = false {
        didSet {
            isLoading ? indicator.startAnimating() : indicator.stopAnimating()
        }
    }
    
    private var items: [GamesListPresentation] = []
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Games"
        navigationItem.searchController = searchController
        vm.load(pageNumber: pageNumber, searchText: nil)
    }
    
    private func loadMore(pageNumber: Int,
                          searchText: String?) {
        isLoading = true
        vm.load(pageNumber: pageNumber,
                searchText: searchText)
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
            self.loadMore(pageNumber: pageNumber, searchText: searchText)
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

extension GamesListVC: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            self.isLoading = true
            let trimmedString = searchText.trimmingCharacters(in: .whitespaces)
            self.searchText = trimmedString
            self.items = []
            self.pageNumber = 1
            vm.load(pageNumber: self.pageNumber, searchText: self.searchText)
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = nil
        self.items = []
        self.pageNumber = 1
        vm.load(pageNumber: self.pageNumber, searchText: nil)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isLoading = false
        self.searchText = nil
        self.items = []
        self.pageNumber = 1
        vm.load(pageNumber: self.pageNumber, searchText: nil)
    }
}
