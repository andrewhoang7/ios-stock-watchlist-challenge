//
//  StarterStockCatalogProvider.swift
//  StockWatchlist
//

import Foundation

protocol StarterStockCatalogProvider {
    func load() -> [StarterStock]
}
