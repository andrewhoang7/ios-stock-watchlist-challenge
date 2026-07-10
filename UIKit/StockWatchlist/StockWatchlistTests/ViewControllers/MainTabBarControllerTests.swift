//
//  MainTabBarControllerTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

@MainActor
final class MainTabBarControllerTests: XCTestCase {
    func testInitCreatesTwoTabs() {
        let tabBarController = MainTabBarController(
            watchlistStore: MockWatchlistStore(),
            catalog: MockStarterStockCatalog(),
            finnhubClient: MockFinnhubClient(),
            imageLoader: MockImageLoader()
        )
        tabBarController.loadViewIfNeeded()

        XCTAssertEqual(tabBarController.viewControllers?.count, 2)
        XCTAssertEqual(tabBarController.viewControllers?[0].tabBarItem.title, "Watchlist")
        XCTAssertEqual(tabBarController.viewControllers?[1].tabBarItem.title, "Browse")
    }

    func testWatchlistTabContainsWatchlistViewController() {
        let tabBarController = MainTabBarController(
            watchlistStore: MockWatchlistStore(),
            catalog: MockStarterStockCatalog(),
            finnhubClient: MockFinnhubClient(),
            imageLoader: MockImageLoader()
        )

        let navigationController = tabBarController.viewControllers?[0] as? UINavigationController
        XCTAssertTrue(navigationController?.viewControllers.first is WatchlistViewController)
    }

    func testBrowseTabContainsStockBrowseViewController() {
        let tabBarController = MainTabBarController(
            watchlistStore: MockWatchlistStore(),
            catalog: MockStarterStockCatalog(),
            finnhubClient: MockFinnhubClient(),
            imageLoader: MockImageLoader()
        )

        let navigationController = tabBarController.viewControllers?[1] as? UINavigationController
        XCTAssertTrue(navigationController?.viewControllers.first is StockBrowseViewController)
    }
}
