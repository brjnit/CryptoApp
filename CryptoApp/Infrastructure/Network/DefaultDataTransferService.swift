//
//  DefaultDataTransferService.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 20/02/22.
//

import Foundation


public final class DefaultDataTransferService {
    
    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolver
    
    public init(with networkService: NetworkService,
                errorResolver: DataTransferErrorResolver = DefaultDataTransferErrorResolver()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
    }
}

extension DefaultDataTransferService: DataTransferService {
    
    public func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                              completion: @escaping CompletionHandler<T>) -> URLSessionTask? where E.Response == T {
        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                completion(result)
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }

    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.invalidJson)
        }
    }
}

