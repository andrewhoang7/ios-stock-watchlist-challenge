//
//  WatchlistStoreTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class WatchlistStoreTests: XCTestCase {
    func testInitDefaultsToEmptyWatchlist() {
        let store = WatchlistStore()

        XCTAssertTrue(store.stocks.isEmpty)
    }

    func testInitPreservesProvidedStocks() {
        let stocks = [StarterStock(symbol: "AAPL", name: "Apple Inc.")]
        let store = WatchlistStore(stocks: stocks)

        XCTAssertEqual(store.stocks, stocks)
    }
}
