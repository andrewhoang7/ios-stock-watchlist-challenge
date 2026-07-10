//
//  StockMetrics.swift
//  StockWatchlist
//

import Foundation

struct StockMetricsResponse: Codable, Sendable {
    let metric: StockMetrics
}

struct StockMetrics: Codable, Sendable {
    let week52High: Double?
    let week52Low: Double?
    let annualDividendYield: Double?

    enum CodingKeys: String, CodingKey {
        case week52High = "52WeekHigh"
        case week52Low = "52WeekLow"
        case annualDividendYield = "dividendYieldIndicatedAnnual"
    }
}
