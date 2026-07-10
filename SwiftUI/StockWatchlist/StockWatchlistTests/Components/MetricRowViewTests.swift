//
//  MetricRowViewTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class MetricRowViewTests: XCTestCase {
    func testAccessibilityLabelCombinesLabelAndValue() {
        XCTAssertEqual(
            MetricRowView.accessibilityLabel(label: "52-week high", value: "$315.45"),
            "52-week high, $315.45"
        )
    }
}
