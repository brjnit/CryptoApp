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
    var didFail: (()-> Void)?
    var numberOfRows: Int {
        return searchedCurrencies?.count ?? 0
    }
    var cryptoCurrencies: [CryptoCurrency]?
    var searchedCurrencies: [CryptoCurrency]?
    var timer: Timer?
    private(set)var errorMessage: String?
    private var searchedValue: String?
    
    init(usecase: MarketUsecase) {
        self.usecase = usecase
    }
    
    func cellViewModel(for index: Int) -> CryptoCellModel? {
        guard let cryptoCurrencies = searchedCurrencies else { return nil }
        let currency = cryptoCurrencies[index]
        let isNegative = currency.changePercent24Hr.contains("-")
        let changePercent24Hr = isNegative ? "\(currency.changePercent24Hr.parse())%".attributedString(textColor: .red) : "+\(currency.changePercent24Hr.parse())%".attributedString(textColor: .green)
        let price = isNegative ? "\(Constant.CurrencySymbol)\(currency.priceUsd.parse())".attributedString(textColor: .red) : "\(Constant.CurrencySymbol)\(currency.priceUsd.parse())".attributedString(textColor: .green)
        return CryptoCellModel(rank: currency.rank, name: currency.name, percentChange: changePercent24Hr, price: price)
    }
    
    
    
    func loadData() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: {[weak self] _ in
            self?.fetchRequest()
        })
        fetchRequest()
    }
    
    private func fetchRequest() {
        _ = self.usecase.fetchMarketData {[weak self] result in
            switch result {
            case .success(let response) : self?.cryptoCurrencies = response.data
                self?.searchedCurrencies = self?.filteredResult(currencies: response.data)
                self?.didUpdate?()
            case .failure(let error):
                if let error = error as? DataTransferError {
                    self?.errorMessage = error.errorMessage()
                }
                self?.didFail?()
            }
        }
    }
    
    func search(with searchText: String?) {
        searchedValue = searchText
        searchedCurrencies = filteredResult(currencies: cryptoCurrencies ?? [])
        didUpdate?()
    }
    
    private func filteredResult(currencies: [CryptoCurrency]) -> [CryptoCurrency] {
        if let searchedValue = searchedValue, searchedValue != "" {
            return currencies.filter({ $0.name.contains(searchedValue)})
        } else { return currencies }
    }
    
    deinit {
        timer?.invalidate()
    }
}


