//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation
import UIKit

class CryptoViewModel {
    let usecase: MarketUsecase
    var didUpdate: (()-> Void)?
    var numberOfRows: Int {
        return cryptoCurrencies?.count ?? 0
    }
    var cryptoCurrencies: [CryptoCurrency]?
    
    init(usecase: MarketUsecase) {
        self.usecase = usecase
    }
    
    func cellViewModel(for index: Int) -> CryptoCellModel? {
        guard let cryptoCurrencies = cryptoCurrencies else { return nil }
        let currency = cryptoCurrencies[index]
    
        return CryptoCellModel(rank: currency.rank, name: currency.name, percentChange: currency.chnagePercent24Hr, price: "\(Constant.CurrencySymbol)\(currency.priceUsd)")
    }
    
    func loadData() {
        self.usecase.fetchMarketData {[weak self] result in
            switch result {
            case .success(let response) : self?.cryptoCurrencies = response.data
                self?.didUpdate?()
            case .failure(let error): break
            }
        }
    }
}


protocol MarketUsecase {
    func fetchMarketData(completion: @escaping (Result<MarketDataModel, Error>)->Void) -> URLSessionTask?
}

struct DefaultMarketUsecase: MarketUsecase {
    let repository: MarketRepository
    func fetchMarketData(completion: @escaping (Result<MarketDataModel, Error>) -> Void) -> URLSessionTask? {
        return repository.getMarketData(with: completion)
    }
}
