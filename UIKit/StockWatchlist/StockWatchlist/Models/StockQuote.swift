//
//  StockQuote.swift
//  StockWatchlist
//

import Foundation

struct StockQuote: Codable, Sendable {
    let currentPrice: Double
    let change: Double?
    let percentChange: Double?

    enum CodingKeys: String, CodingKey {
        case currentPrice = "c"
        case change = "d"
        case percentChange = "dp"
    }
}
