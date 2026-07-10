//
//  StockBrowseViewControllerTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

@MainActor
final class StockBrowseViewControllerTests: XCTestCase {
    func testViewDidLoadSetsTitle() {
        let viewController = makeViewController()
        viewController.loadViewIfNeeded()

        XCTAssertEqual(viewController.title, "Browse")
    }

    private func makeViewController() -> StockBrowseViewController {
        StockBrowseViewController(
            catalog: MockStarterStockCatalog(),
            watchlistStore: MockWatchlistStore(),
            finnhubClient: MockFinnhubClient(),
            imageLoader: MockImageLoader()
        )
    }
}
