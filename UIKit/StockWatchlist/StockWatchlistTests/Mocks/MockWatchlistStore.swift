//
//  MockWatchlistStore.swift
//  StockWatchlistTests
//

import Foundation
@testable import StockWatchlist

final class MockWatchlistStore: WatchlistStoreProvider {
    var stocks: [StarterStock]

    init(stocks: [StarterStock] = []) {
        self.stocks = stocks
    }
}
