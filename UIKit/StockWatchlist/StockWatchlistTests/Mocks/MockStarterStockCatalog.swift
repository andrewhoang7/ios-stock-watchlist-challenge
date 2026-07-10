//
//  MockStarterStockCatalog.swift
//  StockWatchlistTests
//

import Foundation
@testable import StockWatchlist

final class MockStarterStockCatalog: StarterStockCatalogProvider {
    var stocks: [StarterStock]

    init(stocks: [StarterStock] = []) {
        self.stocks = stocks
    }

    func load() -> [StarterStock] {
        stocks
    }
}
