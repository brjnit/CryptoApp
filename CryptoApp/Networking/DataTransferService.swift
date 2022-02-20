//
//  DataTransferService.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import Foundation

//public enum DataTransferError: Error {
//    case serverError
//    case connectionError
//    case badRequest
//    case noContent
//
//    func errorMessage() -> String {
//        switch self {
//        case .serverError: return "Recived server error"
//        case .connectionError: return "Recived connection error"
//        case .badRequest: return "bad request"
//        case .noContent: return "no data content"
//        }
//    }
//}

public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

public protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                       completion: @escaping CompletionHandler<T>) -> URLSessionTask? where E.Response == T
}

public protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}
// MARK: - Error Resolver
public class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    public init() { }
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

// MARK: - Response Decoders
public class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

