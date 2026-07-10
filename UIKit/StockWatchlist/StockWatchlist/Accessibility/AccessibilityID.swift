//
//  AccessibilityID.swift
//  StockWatchlist
//

import Foundation

enum AccessibilityID {
    static let watchlistTab = "watchlist-tab"
    static let browseTab = "browse-tab"

    static let browseScreen = "browse-screen"
    static let watchlistScreen = "watchlist-screen"
    static let stockDetailScreen = "stock-detail-screen"

    static let watchlistEmptyState = "watchlist-empty-state"

    static let browseStockList = "browse-stock-list"
    static let watchlistStockList = "watchlist-stock-list"
    static let browseStockCountHeader = "browse-stock-count-header"

    static let watchlistToggle = "watchlist-toggle"
    static let keyMetricsCard = "key-metrics-card"
    static let stockPrice = "stock-price"
    static let detailLoading = "detail-loading"

    static let metricWeek52High = "metric-week52-high"
    static let metricWeek52Low = "metric-week52-low"
    static let metricDividendYield = "metric-dividend-yield"

    static func stockRow(symbol: String) -> String {
        "stock-row-\(symbol)"
    }
}
