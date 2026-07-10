//
//  TabBarUITests.swift
//  StockWatchlistUITests
//

import XCTest

final class TabBarUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testTabSwitchingShowsWatchlistAndBrowseScreens() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.descendants(matching: .any)[AccessibilityID.watchlistScreen].waitForExistence(timeout: 2))

        app.tabBars.buttons["Browse"].tap()
        XCTAssertTrue(app.descendants(matching: .any)[AccessibilityID.browseScreen].waitForExistence(timeout: 2))

        app.tabBars.buttons["Watchlist"].tap()
        XCTAssertTrue(app.descendants(matching: .any)[AccessibilityID.watchlistScreen].waitForExistence(timeout: 2))
    }
}
