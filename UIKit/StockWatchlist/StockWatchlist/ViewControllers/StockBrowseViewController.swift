//
//  StockBrowseViewController.swift
//  StockWatchlist
//

import UIKit

final class StockBrowseViewController: UITableViewController {
    private let catalog: any StarterStockCatalogProvider
    private let watchlistStore: any WatchlistStoreProvider
    private let finnhubClient: any FinnhubClientProvider
    private let imageLoader: any ImageLoaderProvider

    init(
        catalog: any StarterStockCatalogProvider,
        watchlistStore: any WatchlistStoreProvider,
        finnhubClient: any FinnhubClientProvider,
        imageLoader: any ImageLoaderProvider
    ) {
        self.catalog = catalog
        self.watchlistStore = watchlistStore
        self.finnhubClient = finnhubClient
        self.imageLoader = imageLoader
        super.init(style: .plain)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.accessibilityIdentifier = AccessibilityID.browseScreen
        // TODO
    }
}
