//
//  APIEndpoints.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation

enum EndpointPath: String {
    case getMarketData = "https://api.coincap.io/v2/assets?limit=20&offset=0"
}

struct APIEndpoints {
    static func getMarketData() -> Endpoint<MarketDataModel> {
        return Endpoint(path: "\(EndpointPath.getMarketData.rawValue)", isFullPath: true, method: .get)
    }
}
