//
//  StarterStockCatalogTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class StarterStockCatalogTests: XCTestCase {
    func testLoadReturnsStocksFromFixtureBundle() {
        let catalog = StarterStockCatalog(
            bundle: Bundle(for: StarterStockCatalogTests.self),
            resourceName: "StarterStocks.fixture"
        )
        let stocks = catalog.load()

        XCTAssertEqual(stocks.count, 2)
        XCTAssertEqual(stocks[0].symbol, "TEST")
        XCTAssertEqual(stocks[0].name, "Test Corporation")
        XCTAssertEqual(stocks[1].symbol, "DEMO")
    }

    func testDefaultCatalogLoadUsesAppBundle() {
        let stocks = StarterStockCatalog().load()

        XCTAssertFalse(stocks.isEmpty)
        XCTAssertTrue(stocks.contains(where: { $0.symbol == "AAPL" }))
    }
}
