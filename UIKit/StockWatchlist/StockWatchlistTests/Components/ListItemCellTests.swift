//
//  ListItemCellTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class ListItemCellTests: XCTestCase {
    func testConfigureSetsDisplayedText() {
        let cell = ListItemCell(style: .default, reuseIdentifier: ListItemCell.reuseIdentifier)
        cell.configure(
            primaryText: "Apple Inc.",
            secondaryText: "AAPL",
            showsChevron: true,
            symbol: "AAPL"
        )

        XCTAssertEqual(cell.displayedPrimaryText, "Apple Inc.")
        XCTAssertEqual(cell.displayedSecondaryText, "AAPL")
        XCTAssertTrue(cell.isChevronVisible)
        XCTAssertTrue(cell.isAccessoryVisible)
    }

    func testActivateInvokesHandlerWhenTappable() {
        let cell = ListItemCell(style: .default, reuseIdentifier: ListItemCell.reuseIdentifier)
        var activated = false
        cell.configure(
            primaryText: "Apple Inc.",
            secondaryText: "AAPL",
            showsChevron: true,
            symbol: "AAPL",
            isTappable: true,
            onActivate: { activated = true }
        )

        XCTAssertTrue(cell.accessibilityActivate())
        XCTAssertTrue(activated)
    }

    func testActivateDoesNothingWithoutHandler() {
        let cell = ListItemCell(style: .default, reuseIdentifier: ListItemCell.reuseIdentifier)
        cell.configure(
            primaryText: "Apple Inc.",
            secondaryText: "AAPL",
            showsChevron: false,
            symbol: "AAPL"
        )

        XCTAssertFalse(cell.accessibilityActivate())
    }
}
