//
//  MockFinnhubClient.swift
//  StockWatchlistTests
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation
@testable import StockWatchlist

struct TestError: Error {}

final class MockFinnhubClient: FinnhubClientProvider {
    var quoteResult: Result<StockQuote, Error> =
        .success(StockQuote(currentPrice: 100, change: 1, percentChange: 1))
    var profileResult: Result<CompanyProfile, Error> =
        .success(CompanyProfile(logo: "https://example.com/logo.png"))
    var metricsResult: Result<StockMetrics, Error> =
        .success(StockMetrics(week52High: 200, week52Low: 150, annualDividendYield: 1.2))
    
    private(set) var quoteCallCount = 0
    private(set) var profileCallCount = 0
    private(set) var metricsCallCount = 0
    
    func fetchQuote(symbol: String) async throws -> StockWatchlist.StockQuote {
        quoteCallCount += 1
        return try quoteResult.get()
    }
    
    func fetchCompanyProfile(symbol: String) async throws -> CompanyProfile {
        profileCallCount += 1
        return try profileResult.get()
    }
    
    func fetchMetrics(symbol: String) async throws -> StockMetrics {
        metricsCallCount += 1
        return try metricsResult.get()
    }
}
