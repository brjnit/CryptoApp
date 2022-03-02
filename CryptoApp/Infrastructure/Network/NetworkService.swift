//
//  NetworkService.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation

public enum NetworkError: Error {
    case networkError
    case badRequest
}

public protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> URLSessionTask?
}

public final class DefaultNetworkService {
    
    private let config: NetworkConfigurable
    
    public init(config: NetworkConfigurable) {
        self.config = config
    }
    
    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask {
        let sessionDataTask = URLSession.shared.dataTask(with: request) { data, response, requestError in
            
            if requestError != nil {
                completion(.failure(.networkError))
            } else {
                completion(.success(data))
            }
        }
        sessionDataTask.resume()
        return sessionDataTask
    }
}

extension DefaultNetworkService: NetworkService {
    
    public func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> URLSessionTask? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.badRequest))
            return nil
        }
    }
}

enum RequestGenerationError: Error {
    case components
}

extension Requestable {
    
    func url(with config: NetworkConfigurable) throws -> URL {

        let baseURL = config.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)
        
        guard let urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
    public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
}

