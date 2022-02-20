//
//  APIEndpoints.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation

enum EndpointPath: String {
    case getMarketData = "https://api.coincap.io/v2/assets"
}

struct APIEndpoints {
    static func getMarketData() -> Endpoint {
        return Endpoint(path: "\(EndpointPath.getMarketData.rawValue)", method: .get)
    }
}

public struct Endpoint {
    var path: String
    var method: HTTPMethodType
    var headers: [String: String]? = [:]
    var queryItems: [String: String]? = [:]
}

extension Endpoint {
    var urlComponents: URLComponents {
        let baseUrl: String = "https://api.coincap.io/v2"
        var component = URLComponents(string: baseUrl)!
        component.path = path
       // component.queryItems = queryItems
        return component
    }
    
    var request: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod  = method.rawValue
        if  let headers = headers {
            for(headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        return request
    }
}
