//
//  MarketRepository.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation

struct DefaultMarketRepository: MarketRepository {
    let service: DataTransferService
    func getMarketData(with completion: @escaping (Result<MarketDataModel, Error>) -> Void) -> URLSessionTask? {
        let endpoint = APIEndpoints.getMarketData()
        return service.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}


