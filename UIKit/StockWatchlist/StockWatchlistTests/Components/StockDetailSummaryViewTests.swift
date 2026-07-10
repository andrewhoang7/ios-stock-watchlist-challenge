//
//  StockDetailSummaryViewTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class StockDetailSummaryViewTests: XCTestCase {
    private let stock = StarterStock(symbol: "AAPL", name: "Apple Inc.")

    func testConfigureSetsNameSymbolAndPrice() {
        let view = StockDetailSummaryView()
        let quote = StockQuote(currentPrice: 150.25, change: 2.5, percentChange: 1.69)
        view.configure(stock: stock, quote: quote, logo: nil)

        XCTAssertEqual(view.displayedName, "Apple Inc.")
        XCTAssertEqual(view.displayedSymbol, "AAPL")
        XCTAssertEqual(
            view.displayedPrice,
            quote.currentPrice.formatted(.currency(code: "USD"))
        )
    }

    func testConfigureShowsPositiveChange() {
        let view = StockDetailSummaryView()
        let quote = StockQuote(currentPrice: 150.25, change: 2.5, percentChange: 1.69)
        view.configure(stock: stock, quote: quote, logo: nil)

        XCTAssertTrue(view.isChangeVisible)
    }

    func testConfigureShowsNegativeChange() {
        let view = StockDetailSummaryView()
        let quote = StockQuote(currentPrice: 150.25, change: -2.5, percentChange: -1.69)
        view.configure(stock: stock, quote: quote, logo: nil)

        XCTAssertTrue(view.isChangeVisible)
    }

    func testConfigureHidesChangeWhenMissing() {
        let view = StockDetailSummaryView()
        let quote = StockQuote(currentPrice: 150.25, change: nil, percentChange: nil)
        view.configure(stock: stock, quote: quote, logo: nil)

        XCTAssertFalse(view.isChangeVisible)
    }
}
