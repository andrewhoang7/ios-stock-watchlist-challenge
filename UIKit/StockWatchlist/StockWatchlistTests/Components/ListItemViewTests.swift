//
//  ListItemViewTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class ListItemViewTests: XCTestCase {
    func testConfigureSetsPrimaryAndSecondaryText() {
        let view = ListItemView()
        view.configure(
            primaryText: "Apple Inc.",
            secondaryText: "AAPL",
            showsChevron: false,
            accessory: nil
        )

        XCTAssertEqual(view.displayedPrimaryText, "Apple Inc.")
        XCTAssertEqual(view.displayedSecondaryText, "AAPL")
    }

    func testConfigureHidesSecondaryTextWhenNil() {
        let view = ListItemView()
        view.configure(
            primaryText: "Apple Inc.",
            secondaryText: nil,
            showsChevron: false,
            accessory: nil
        )

        XCTAssertEqual(view.displayedSecondaryText, nil)
    }

    func testConfigureHidesSecondaryTextWhenEmpty() {
        let view = ListItemView()
        view.configure(
            primaryText: "Apple Inc.",
            secondaryText: "",
            showsChevron: false,
            accessory: nil
        )

        XCTAssertEqual(view.displayedSecondaryText, "")
    }

    func testConfigureShowsChevronWhenRequested() {
        let view = ListItemView()
        view.configure(
            primaryText: "Apple Inc.",
            secondaryText: "AAPL",
            showsChevron: true,
            accessory: nil
        )

        XCTAssertTrue(view.isChevronVisible)
    }

    func testConfigureHidesChevronByDefault() {
        let view = ListItemView()
        view.configure(
            primaryText: "Apple Inc.",
            secondaryText: "AAPL",
            showsChevron: false,
            accessory: nil
        )

        XCTAssertFalse(view.isChevronVisible)
    }

    func testConfigureShowsAccessoryWhenProvided() {
        let view = ListItemView()
        let accessory = StockSymbolAccessoryView(symbol: "AAPL")
        view.configure(
            primaryText: "Apple Inc.",
            secondaryText: "AAPL",
            showsChevron: false,
            accessory: accessory
        )

        XCTAssertTrue(view.isAccessoryVisible)
    }

    func testConfigureHidesAccessoryWhenNil() {
        let view = ListItemView()
        view.configure(
            primaryText: "Apple Inc.",
            secondaryText: "AAPL",
            showsChevron: false,
            accessory: nil
        )

        XCTAssertFalse(view.isAccessoryVisible)
    }
}
