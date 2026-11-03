//
//  WatchlistFlowUITests.swift
//  StockWatchlistUITests
//
//  Created by Andrew Hoang on 11/3/26.
//

import Foundation
import XCTest

final class WatchlistFlowUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchEnvironment["UI_TESTING"] = "1"
        app.launch()
    }
    
    private func element(_ identifier: String) -> XCUIElement {
        app.descendants(matching: .any)[identifier].firstMatch
    }
    
    private func openDetail(for symbol: String) {
        app.tabBars.buttons["Browse"].tap()
        let row = element(AccessibilityID.stockRow(symbol: symbol))
        XCTAssertTrue(row.waitForExistence(timeout: 2))
        row.tap()
        XCTAssertTrue(element(AccessibilityID.stockDetailScreen).waitForExistence(timeout: 2))
    }
    
    func testShowCatalogWithCountHeader() {
        app.tabBars.buttons["Browse"].tap()
        print(app.debugDescription)
        XCTAssertTrue(element(AccessibilityID.browseStockList).waitForExistence(timeout: 2))
        XCTAssertTrue(element(AccessibilityID.browseStockCountHeader).waitForExistence(timeout: 2))
        XCTAssertTrue(element(AccessibilityID.stockRow(symbol: "AAPL")).waitForExistence(timeout: 2))
    }
    
    func testStockDetailShowsPriceAndMetrics() {
        openDetail(for: "AAPL")
        XCTAssertTrue(element(AccessibilityID.stockPrice).waitForExistence(timeout: 2))
        XCTAssertTrue(element(AccessibilityID.keyMetricsCard).waitForExistence(timeout: 2))
        XCTAssertTrue(element(AccessibilityID.metricWeek52Low).waitForExistence(timeout: 2))
        XCTAssertTrue(element(AccessibilityID.metricWeek52High).waitForExistence(timeout: 2))
    }
    
    func testAddAndRemoveUpdatesWatchListTab() {
        openDetail(for: "AAPL")
        //Add
        let toggle = element(AccessibilityID.watchlistToggle)
        XCTAssertTrue(toggle.waitForExistence(timeout: 2))
        toggle.tap()
        app.tabBars.buttons["Watchlist"].tap()
        XCTAssertTrue(element(AccessibilityID.stockRow(symbol: "AAPL")).waitForExistence(timeout: 2))
        
        //Remove
        app.tabBars.buttons["Browse"].tap()
        XCTAssertTrue(toggle.waitForExistence(timeout: 2))
        toggle.tap()
        app.tabBars.buttons["Watchlist"].tap()
        XCTAssertTrue(element(AccessibilityID.watchlistEmptyState).waitForExistence(timeout: 2))
    }
    
    
    
}
