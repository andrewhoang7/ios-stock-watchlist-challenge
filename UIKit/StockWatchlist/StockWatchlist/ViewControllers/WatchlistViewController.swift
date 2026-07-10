//
//  WatchlistViewController.swift
//  StockWatchlist
//

import UIKit

final class WatchlistViewController: UITableViewController {
    private let watchlistStore: any WatchlistStoreProvider
    private let emptyStateView = UIContentUnavailableView(configuration: WatchlistViewController.emptyConfiguration())

    init(watchlistStore: any WatchlistStoreProvider) {
        self.watchlistStore = watchlistStore
        super.init(style: .plain)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Watchlist"
        view.accessibilityIdentifier = AccessibilityID.watchlistScreen
        tableView.register(ListItemCell.self, forCellReuseIdentifier: ListItemCell.reuseIdentifier)

        setUpEmptyStateView()
        refreshContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshContent()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchlistStore.stocks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ListItemCell.reuseIdentifier,
            for: indexPath
        ) as! ListItemCell

        let stock = watchlistStore.stocks[indexPath.row]
        cell.configure(
            primaryText: stock.name,
            secondaryText: stock.symbol,
            showsChevron: false,
            symbol: stock.symbol,
            rowAccessibilityIdentifier: AccessibilityID.stockRow(symbol: stock.symbol)
        )
        return cell
    }

    private func setUpEmptyStateView() {
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.accessibilityIdentifier = AccessibilityID.watchlistEmptyState
        emptyStateView.isUserInteractionEnabled = false
        view.addSubview(emptyStateView)

        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func refreshContent() {
        tableView.reloadData()
        emptyStateView.isHidden = !watchlistStore.stocks.isEmpty
    }

    private static func emptyConfiguration() -> UIContentUnavailableConfiguration {
        var configuration = UIContentUnavailableConfiguration.empty()
        configuration.image = UIImage(systemName: "star")
        configuration.text = "No stocks yet"
        configuration.secondaryText = "Browse stocks and add them to your watchlist."
        return configuration
    }
}
