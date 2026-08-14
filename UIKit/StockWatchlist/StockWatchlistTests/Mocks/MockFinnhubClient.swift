//
//  MockFinnhubClient.swift
//  StockWatchlistTests
//

import Foundation
@testable import StockWatchlist

final class MockFinnhubClient: FinnhubClientProvider {
    var quote = StockQuote(currentPrice: 100, change: 1, percentChange: 1)
    var profile = CompanyProfile(logo: nil)
    var metrics = StockMetrics(week52High: 200, week52Low: 150, annualDividendYield: 1.2)

    func fetchQuote(symbol: String) async throws -> StockQuote {
        quote
    }

    func fetchCompanyProfile(symbol: String) async throws -> CompanyProfile {
        profile
    }

    func fetchMetrics(symbol: String) async throws -> StockMetrics {
        metrics
    }
}
