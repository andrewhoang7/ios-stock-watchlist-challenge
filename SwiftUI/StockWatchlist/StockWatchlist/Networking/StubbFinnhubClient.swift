//
//  StubbFinnhubClient.swift
//  StockWatchlist
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation

struct StubbFinnhubClient: FinnhubClientProvider {
    func fetchQuote(symbol: String) async throws -> StockQuote {
        StockQuote(currentPrice: 123.45, change: 1.23, percentChange: 1.01)
    }
    
    func fetchCompanyProfile(symbol: String) async throws -> CompanyProfile {
        CompanyProfile(logo: nil)
    }
    
    func fetchMetrics(symbol: String) async throws -> StockMetrics {
        StockMetrics(week52High: 150, week52Low: 100, annualDividendYield: 0.5)
    }
    
    
}
