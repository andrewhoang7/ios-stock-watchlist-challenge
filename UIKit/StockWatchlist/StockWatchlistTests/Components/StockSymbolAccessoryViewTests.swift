//
//  StockSymbolAccessoryViewTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class StockSymbolAccessoryViewTests: XCTestCase {
    func testInitDisplaysFirstLetterOfSymbol() {
        let view = StockSymbolAccessoryView(symbol: "AAPL")

        XCTAssertEqual(view.firstLabel()?.text, "A")
    }

    func testInitUsesSingleCharacterForSingleLetterSymbol() {
        let view = StockSymbolAccessoryView(symbol: "X")

        XCTAssertEqual(view.firstLabel()?.text, "X")
    }
}
