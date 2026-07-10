//
//  FinnhubClientProvider.swift
//  StockWatchlist
//

import Foundation

protocol FinnhubClientProvider {
    func fetchQuote(symbol: String) async throws -> StockQuote
    func fetchCompanyProfile(symbol: String) async throws -> CompanyProfile
    func fetchMetrics(symbol: String) async throws -> StockMetrics
}
