//
//  WatchlistViewControllerTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

@MainActor
final class WatchlistViewControllerTests: XCTestCase {
    func testViewDidLoadSetsTitle() {
        let viewController = WatchlistViewController(watchlistStore: MockWatchlistStore())
        viewController.loadViewIfNeeded()

        XCTAssertEqual(viewController.title, "Watchlist")
    }

    func testEmptyWatchlistShowsEmptyState() {
        let viewController = WatchlistViewController(watchlistStore: MockWatchlistStore())
        viewController.loadViewIfNeeded()

        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 0)

        let emptyLabel = viewController.view.firstLabel(withText: "No stocks yet")
        XCTAssertNotNil(emptyLabel)
        XCTAssertFalse(emptyLabel?.isHiddenInHierarchy ?? true)
    }

    func testPopulatedWatchlistHidesEmptyStateAndShowsRows() {
        let stocks = [
            StarterStock(symbol: "AAPL", name: "Apple Inc."),
            StarterStock(symbol: "MSFT", name: "Microsoft Corporation")
        ]
        let viewController = WatchlistViewController(watchlistStore: MockWatchlistStore(stocks: stocks))
        viewController.loadViewIfNeeded()

        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 2)

        let emptyLabel = viewController.view.firstLabel(withText: "No stocks yet")
        XCTAssertTrue(emptyLabel?.isHiddenInHierarchy ?? false)
    }

    func testCellForRowConfiguresStockDetails() {
        let stock = StarterStock(symbol: "AAPL", name: "Apple Inc.")
        let viewController = WatchlistViewController(watchlistStore: MockWatchlistStore(stocks: [stock]))
        viewController.loadViewIfNeeded()

        let cell = viewController.tableView(
            viewController.tableView,
            cellForRowAt: IndexPath(row: 0, section: 0)
        ) as! ListItemCell

        XCTAssertEqual(cell.displayedPrimaryText, "Apple Inc.")
        XCTAssertEqual(cell.displayedSecondaryText, "AAPL")
        XCTAssertFalse(cell.isChevronVisible)
    }

    func testViewWillAppearRefreshesContent() {
        let store = MockWatchlistStore()
        let viewController = WatchlistViewController(watchlistStore: store)
        viewController.loadViewIfNeeded()
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 0)

        store.stocks = [StarterStock(symbol: "AAPL", name: "Apple Inc.")]
        viewController.viewWillAppear(false)

        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 1)
    }
}
