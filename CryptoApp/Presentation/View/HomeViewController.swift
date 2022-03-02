//
//  HomeViewController.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: CryptoViewModel!
    private var pendingRequestWorkItem: DispatchWorkItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationItem.title = "Crypto Market"
        searchBar.placeholder = "Search Crypto"
        tableView.register(CryptoTableViewCell.nib, forCellReuseIdentifier: CryptoTableViewCell.reuseIdendifier)
        tableView.tableFooterView = UIView(frame: .zero)
        bindViewModel()
        showLoadingIndicator()
        viewModel.loadData()
    }
    
    func bindViewModel() {
        viewModel.didUpdate = { [weak self]  in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingIndicator()
                self?.tableView.reloadData()
            }
        }
        viewModel.didFail = { [weak self]  in
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingIndicator()
                self?.showAlert(message : self?.viewModel.errorMessage ?? "")
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.reuseIdendifier) as? CryptoTableViewCell,  let cellVm = viewModel.cellViewModel(for: indexPath.row) else { return UITableViewCell() }
        
        cell.configureCell(model: cellVm)
        return cell
    }
    
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pendingRequestWorkItem?.cancel()
        let requestItem = DispatchWorkItem {[weak self] in
            self?.viewModel.search(with: searchText)
        }
        pendingRequestWorkItem = requestItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: requestItem)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(with: "")
        searchBar.resignFirstResponder()
    }
}
