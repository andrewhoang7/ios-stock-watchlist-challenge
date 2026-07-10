//
//  MetricRowViewTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class MetricRowViewTests: XCTestCase {
    func testInitSetsAccessibilityLabel() {
        let view = MetricRowView(label: "52-week high", value: "$315.45")

        XCTAssertEqual(view.accessibilityLabel, "52-week high, $315.45")
        XCTAssertTrue(view.isAccessibilityElement)
    }
}
