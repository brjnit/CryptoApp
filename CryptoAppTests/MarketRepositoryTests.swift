//
//  MarketRepositoryTests.swift
//  CryptoAppTests
//
//  Created by Brajesh Kumar on 20/02/22.
//

import XCTest
@testable import CryptoApp

class MarketRepositoryTests: XCTestCase {
    func testFethMarketDataWithSuccess() {
        let sut = makeSUT(with: .success(stubMarketData()))
        let expectation = self.expectation(description: "get market data model")
        var marketData: MarketDataModel?
        
        _ = sut.getMarketData(with: { result in
            switch result {
            case .success(let response): marketData = response
            case .failure(_): XCTFail("should return market data")
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertEqual(marketData?.data[0].id, "bitcoin")
    }
    
    func testFethMarketDataWithFailure() {
        let sut = makeSUT(with: .failure(.noResponse))
        let expectation = self.expectation(description: "get market Api fail")
        var error: Error?
        
        _ = sut.getMarketData(with: { result in
            switch result {
            case .success( _): XCTFail("should not return market data")
            case .failure(let serverError): error = serverError
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(error)
    }
    
    private func makeSUT(with result: Result<MarketDataModel,DataTransferError>?) -> MarketRepository {
        return DefaultMarketRepository(service: MockDataTransferService<MarketDataModel>(with: result))
    }
}
