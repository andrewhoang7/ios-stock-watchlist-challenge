//
//  WatchlistStore.swift
//  StockWatchlist
//

import Foundation
import Observation

@Observable
final class WatchlistStore: WatchlistStoreProvider {
    private(set) var stocks: [StarterStock]

    init(stocks: [StarterStock] = []) {
        self.stocks = stocks
    }

    // TODO
}
