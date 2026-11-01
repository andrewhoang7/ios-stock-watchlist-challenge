//
//  FinnhubClientFactoryTests.swift
//  StockWatchlistTests
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation
import XCTest
@testable import StockWatchlist

final class FinnhubClientFactoryTests: XCTestCase {
    func testReturnStubWhenUITesting() {
        let client = FinnhubClientFactory.make(environment: ["UI_TESTING": "1"])
        XCTAssertTrue(client is StubbFinnhubClient)
    }
    
    func testReturnsRealClientOtherWise() {
        let client = FinnhubClientFactory.make(environment: [:])
        XCTAssertTrue(client is FinnhubClient)
    }
}
