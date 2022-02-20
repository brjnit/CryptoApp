//
//  MarketRepository.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation

struct MerketService: MarketRepository {
    let service: DataTransferService
    func getMarketData(with completion: @escaping (Result<MarketDataModel, Error>) -> Void) -> NetworkCancellable? {
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



enum APIError: Error {
    case invalidData
    case requestFailed
    case jsonConversionFailure
    case jsonParsingFailure
    case responseUnsuccessful
    
    var localizedDescription: String {
        switch self {
        case .invalidData:
            return "Invalid Data"
        case .requestFailed:
            return "Request Failed"
        case .jsonConversionFailure:
            return "JSON Conversion Failure"
        case .jsonParsingFailure:
            return "JSON Parsing Failure"
        case .responseUnsuccessful:
            return "Response Unsuccessful"
        }
    }
}


