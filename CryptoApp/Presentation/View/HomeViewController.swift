//
//  HomeViewController.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CryptoViewModel!
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.register(CryptoTableViewCell.nib, forCellReuseIdentifier: CryptoTableViewCell.reuseIdendifier)
            bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.didUpdate = { [weak self] in
            
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
