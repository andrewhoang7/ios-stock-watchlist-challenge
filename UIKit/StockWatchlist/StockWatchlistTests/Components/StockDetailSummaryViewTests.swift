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
        XCTAssertEqual(view.displayedChange, expectedChangeText(change: 2.5, percentChange: 1.69))
        XCTAssertNotEqual(
            view.displayedChange,
            expectedChangeTextWithoutScaling(change: 2.5, percentChange: 1.69)
        )
    }

    func testConfigureShowsNegativeChange() {
        let view = StockDetailSummaryView()
        let quote = StockQuote(currentPrice: 150.25, change: -2.5, percentChange: -1.69)
        view.configure(stock: stock, quote: quote, logo: nil)

        XCTAssertTrue(view.isChangeVisible)
        XCTAssertEqual(view.displayedChange, expectedChangeText(change: -2.5, percentChange: -1.69))
    }

    func testConfigureHidesChangeWhenMissing() {
        let view = StockDetailSummaryView()
        let quote = StockQuote(currentPrice: 150.25, change: nil, percentChange: nil)
        view.configure(stock: stock, quote: quote, logo: nil)

        XCTAssertFalse(view.isChangeVisible)
        XCTAssertNil(view.displayedChange)
    }

    func testFormattedPercentChangeTreatsFinnhubValueAsPercentageNotFraction() {
        let quote = StockQuote(currentPrice: 150.25, change: 2.5, percentChange: 1.69)

        XCTAssertEqual(
            quote.formattedPercentChange,
            (1.69 / 100).formatted(.percent.precision(.fractionLength(2)))
        )
        XCTAssertNotEqual(
            quote.formattedPercentChange,
            1.69.formatted(.percent.precision(.fractionLength(2)))
        )
    }

    private func expectedChangeText(change: Double, percentChange: Double) -> String {
        let changeText = change.formatted(.currency(code: "USD"))
        let percentText = (percentChange / 100).formatted(.percent.precision(.fractionLength(2)))
        return "\(changeText) (\(percentText))"
    }

    private func expectedChangeTextWithoutScaling(change: Double, percentChange: Double) -> String {
        let changeText = change.formatted(.currency(code: "USD"))
        let percentText = percentChange.formatted(.percent.precision(.fractionLength(2)))
        return "\(changeText) (\(percentText))"
    }
}
