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
    
    private let apple = StarterStock(symbol: "AAPL", name: "Apple Inc.")
    private let microsoft = StarterStock(symbol: "MSFT", name: "Microsoft Corporation")
    
    func testAddAppendsStock() {
        let store = WatchlistStore()
        store.add(apple)
        XCTAssertEqual(store.stocks, [apple])
    }
    
    func testAddIgnoresDuplicates() {
        let store = WatchlistStore()
        
        store.add(apple)
        store.add(microsoft)
        XCTAssertEqual(store.stocks.count, 2)
    }
    
    func testAddPreservesInsertionOrder() {
        let store = WatchlistStore()
        
        store.add(microsoft)
        store.add(apple)
        XCTAssertEqual(store.stocks.map(\.symbol), ["MSFT", "AAPL"])
    }
    
    func testRemoveDeletesStock() {
        let store = WatchlistStore(stocks: [apple, microsoft])
                                   
        store.remove(apple)
        XCTAssertEqual(store.stocks, [microsoft])
    }
    
    func testRemoveMissingStockDoesNothing() {
        let store = WatchlistStore(stocks: [microsoft])
        store.remove(apple)
        XCTAssertEqual(store.stocks, [microsoft])
    }
    
    func testContainsReflectsMembership() {
        let store = WatchlistStore()
        XCTAssertFalse(store.contains(apple))
        
        store.add(apple)
        XCTAssertTrue(store.contains(apple))
        
        store.remove(apple)
        XCTAssertFalse(store.contains(apple))
    }
    
}
