//
//  MareketUsecase.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation
protocol MarketUsecase {
    func fetchMarketData(completion: @escaping (Result<MarketDataModel, Error>)->Void) -> URLSessionTask?
}

struct DefaultMarketUsecase: MarketUsecase {
    let repository: MarketRepository
    func fetchMarketData(completion: @escaping (Result<MarketDataModel, Error>) -> Void) -> URLSessionTask? {
        return repository.getMarketData(with: completion)
    }
}
