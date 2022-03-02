//
//  MarketRepository.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation

protocol MarketRepository {
    func getMarketData(with completion: @escaping (Result<MarketDataModel, Error>)->Void) -> URLSessionTask?
}
