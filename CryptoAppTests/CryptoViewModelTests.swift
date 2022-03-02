//
//  CryptoViewModelTests.swift
//  CryptoAppTests
//
//  Created by Brajesh Kumar on 20/02/22.
//

import XCTest
@testable import CryptoApp

class CryptoViewModelTests: XCTestCase {

    func testCryptoViewModel_onLoadData() {
        let sut = makeSUT(with: .success(stubMarketData()))
        let expectation = self.expectation(description: "load presentation data")
        sut.didUpdate = {
            expectation.fulfill()
        }
        sut.loadData()
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertEqual(sut.numberOfRows,3)
        XCTAssertEqual(sut.cellViewModel(for: 0)?.rank,"1")
        XCTAssertEqual(sut.cellViewModel(for: 0)?.name,"Bitcoin")
        XCTAssertEqual(sut.cellViewModel(for: 0)?.percentChange,"-2.02%".attributedString(textColor: .red))
        XCTAssertEqual(sut.cellViewModel(for: 0)?.price,"$40040.60".attributedString(textColor: .red))
        XCTAssertEqual(sut.cellViewModel(for: 2)?.percentChange,"+0.04%".attributedString(textColor: .green))
        XCTAssertEqual(sut.cellViewModel(for: 2)?.price,"$1.00".attributedString(textColor: .green))
    }
    
    func testCryptoViewModel_searchedData() {
        let sut = makeSUT(with: .success(stubMarketData()))
        let expectation = self.expectation(description: "searched presentation data")
        sut.loadData()
        sut.didUpdate = {
            expectation.fulfill()
        }
        sut.search(with: "Bit")
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertEqual(sut.numberOfRows,1)
        XCTAssertEqual(sut.cellViewModel(for: 0)?.name,"Bitcoin")
    }
    
    
    private func makeSUT(with result: Result<MarketDataModel,DataTransferError>?) -> CryptoViewModel {
        let repository = DefaultMarketRepository(service: MockDataTransferService<MarketDataModel>(with: result))
        let usecase = DefaultMarketUsecase(repository: repository)
        return CryptoViewModel(usecase: usecase)
    }
}
