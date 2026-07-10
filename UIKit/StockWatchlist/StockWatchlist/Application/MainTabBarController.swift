//
//  MainTabBarController.swift
//  StockWatchlist
//

import UIKit

final class MainTabBarController: UITabBarController {
    init(
        watchlistStore: any WatchlistStoreProvider,
        catalog: any StarterStockCatalogProvider,
        finnhubClient: any FinnhubClientProvider,
        imageLoader: any ImageLoaderProvider
    ) {
        super.init(nibName: nil, bundle: nil)

        viewControllers = [
            navigationController(
                rootViewController: WatchlistViewController(watchlistStore: watchlistStore),
                title: "Watchlist",
                systemImage: "star.fill",
                tag: 0,
                accessibilityIdentifier: AccessibilityID.watchlistTab
            ),
            navigationController(
                rootViewController: StockBrowseViewController(
                    catalog: catalog,
                    watchlistStore: watchlistStore,
                    finnhubClient: finnhubClient,
                    imageLoader: imageLoader
                ),
                title: "Browse",
                systemImage: "list.bullet",
                tag: 1,
                accessibilityIdentifier: AccessibilityID.browseTab
            )
        ]
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func navigationController(
        rootViewController: UIViewController,
        title: String,
        systemImage: String,
        tag: Int,
        accessibilityIdentifier: String
    ) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: systemImage),
            tag: tag
        )
        navigationController.tabBarItem.accessibilityIdentifier = accessibilityIdentifier
        return navigationController
    }
}
