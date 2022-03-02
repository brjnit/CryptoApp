//
//  MockDataTransferService.swift
//  CryptoAppTests
//
//  Created by Brajesh Kumar on 20/02/22.
//

import Foundation
@testable import CryptoApp

class MockDataTransferService<T> {
    var result: Result<T,DataTransferError>?
    
    init(with stubResult: Result<T,DataTransferError>? = nil) {
        self.result = stubResult
    }
}

extension MockDataTransferService: DataTransferService {
    func request<T, E>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> URLSessionTask? where T : Decodable, T == E.Response, E : ResponseRequestable {
        completion(result as! Result<T, DataTransferError>)
        return nil
    }
}

func stubMarketData() -> MarketDataModel{
    return try! JSONDecoder().decode(MarketDataModel.self, from: stubMarketDataString.data(using: .utf8)!)
}

let stubMarketDataString = """
{
  "data": [
    {
      "id": "bitcoin",
      "rank": "1",
      "symbol": "BTC",
      "name": "Bitcoin",
      "supply": "18962493.0000000000000000",
      "maxSupply": "21000000.0000000000000000",
      "marketCapUsd": "759269690470.4015478635758332",
      "volumeUsd24Hr": "10781232829.6207468610004126",
      "priceUsd": "40040.6049178450084524",
      "changePercent24Hr": "-2.0179874060513985",
      "vwap24Hr": "40194.1820207736057772",
      "explorer": "https://blockchain.info/"
    },
    {
      "id": "ethereum",
      "rank": "2",
      "symbol": "ETH",
      "name": "Ethereum",
      "supply": "119642120.3115000000000000",
      "maxSupply": null,
      "marketCapUsd": "333999493623.3325145052209191",
      "volumeUsd24Hr": "10128315913.8192271988550160",
      "priceUsd": "2791.6547513010640356",
      "changePercent24Hr": "-4.5917039059967529",
      "vwap24Hr": "2820.8336061403937382",
      "explorer": "https://etherscan.io/"
    },
    {
      "id": "tether",
      "rank": "3",
      "symbol": "USDT",
      "name": "Tether",
      "supply": "78997501612.7809400000000000",
      "maxSupply": null,
      "marketCapUsd": "79189400470.9994651356801091",
      "volumeUsd24Hr": "25657287262.4764976366024506",
      "priceUsd": "1.0024291762941966",
      "changePercent24Hr": "0.0419072968364377",
      "vwap24Hr": "1.0014847385847987",
      "explorer": "https://www.omniexplorer.info/asset/31"
    }
    
  ],
  "timestamp": 1645265462543
}
"""


