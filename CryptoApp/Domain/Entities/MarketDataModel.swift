//
//  CryptoDataModel.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation

struct MarketDataModel: Codable {
    let data: [CryptoCurrency]
}

struct CryptoCurrency: Codable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let priceUsd: String
    let changePercent24Hr: String
}
