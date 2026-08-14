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

    var formattedPercentChange: String? {
        guard let percentChange else { return nil }
        return (percentChange / 100).formatted(.percent.precision(.fractionLength(2)))
    }
}
