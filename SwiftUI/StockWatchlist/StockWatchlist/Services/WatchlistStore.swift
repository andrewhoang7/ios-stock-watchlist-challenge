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
    func contains(_ stock: StarterStock) -> Bool {
        stocks.contains {$0.symbol == stock.symbol}
    }
    
    func add(_ stock: StarterStock) {
        guard !contains(stock) else { return }
        stocks.append(stock)
    }
    
    func remove(_ stock: StarterStock) {
        stocks.removeAll(where: {$0.symbol == stock.symbol})
    }
}
