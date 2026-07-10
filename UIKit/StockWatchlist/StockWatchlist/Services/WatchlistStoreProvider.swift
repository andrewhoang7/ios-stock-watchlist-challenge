//
//  WatchlistStoreProvider.swift
//  StockWatchlist
//

import Foundation

protocol WatchlistStoreProvider: AnyObject {
    var stocks: [StarterStock] { get }
}
