//
//  CryptoTableViewCell.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation
import UIKit

class CryptoTableViewCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    static let reuseIdendifier: String = String(describing: self)
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: CryptoCellModel) {
        rankLabel.text = model.rank
        nameLabel.text = model.name
        percentChangeLabel.text = model.percentChange
        priceLabel.text = model.price
    }
}

struct CryptoCellModel {
    let rank: String
    let name: String
    let percentChange: String
    let price: String
}
