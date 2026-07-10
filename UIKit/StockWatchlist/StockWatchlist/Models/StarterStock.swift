//
//  StarterStock.swift
//  StockWatchlist
//

import Foundation

struct StarterStock: Codable, Sendable, Identifiable, Hashable {
    var id: String { symbol }
    let symbol: String
    let name: String
}
