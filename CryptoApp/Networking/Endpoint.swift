//
//  Endpoint.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation
public enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethodType { get }
    var headerParamaters: [String: String] { get }
    var queryParameters: [String: Any] { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    var responseDecoder: ResponseDecoder { get }
}

public class Endpoint<R>: ResponseRequestable {
    
    public typealias Response = R
    
    public let path: String
    public let isFullPath: Bool
    public let method: HTTPMethodType
    public let headerParamaters: [String: String]
    public let queryParameters: [String: Any]
    public let responseDecoder: ResponseDecoder
    
    init(path: String,
         isFullPath: Bool = false,
         method: HTTPMethodType,
         headerParamaters: [String: String] = [:],
         queryParameters: [String: Any] = [:],
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParameters = queryParameters
        self.responseDecoder = responseDecoder
    }
}
