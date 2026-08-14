//
//  StockDetailSummaryViewTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class StockDetailSummaryViewTests: XCTestCase {
    func testShouldShowChangeWhenQuoteIncludesChangeData() {
        let quote = StockQuote(currentPrice: 150.25, change: 2.5, percentChange: 1.69)

        XCTAssertTrue(StockDetailSummaryView.shouldShowChange(in: quote))
    }

    func testShouldHideChangeWhenQuoteIsMissingChangeData() {
        let quote = StockQuote(currentPrice: 150.25, change: nil, percentChange: nil)

        XCTAssertFalse(StockDetailSummaryView.shouldShowChange(in: quote))
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

    func testFormattedPercentChangeFormatsNegativeValues() {
        let quote = StockQuote(currentPrice: 150.25, change: -2.5, percentChange: -1.69)

        XCTAssertEqual(
            quote.formattedPercentChange,
            (-1.69 / 100).formatted(.percent.precision(.fractionLength(2)))
        )
    }

    func testFormattedPercentChangeIsNilWhenMissing() {
        let quote = StockQuote(currentPrice: 150.25, change: nil, percentChange: nil)

        XCTAssertNil(quote.formattedPercentChange)
    }
}
