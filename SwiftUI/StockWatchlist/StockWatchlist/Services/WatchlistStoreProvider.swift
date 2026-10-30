//
//  WatchlistStoreProvider.swift
//  StockWatchlist
//

import Foundation

protocol WatchlistStoreProvider: AnyObject {
    var stocks: [StarterStock] { get }
    func contains(_ stock: StarterStock) -> Bool
    func add(_ stock: StarterStock)
    func remove(_ stock: StarterStock)
}
