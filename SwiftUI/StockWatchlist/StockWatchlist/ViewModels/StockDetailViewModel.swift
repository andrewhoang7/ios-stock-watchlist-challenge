//
//  StockDetailViewModel.swift
//  StockWatchlist
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation
import Observation

struct StockDetailContent {
    let quote: StockQuote
    let logoURL: URL?
    let metrics: StockMetrics?
}

@MainActor
@Observable
final class StockDetailViewModel {
    enum State {
        case loading
        case loaded(StockDetailContent)
        case failed(String)
    }
    
    let stock: StarterStock
    private(set) var state: State = .loading
    private let finnhubClient: any FinnhubClientProvider
    
    init(stock: StarterStock, finnhubClient: any FinnhubClientProvider) {
        self.stock = stock
        self.finnhubClient = finnhubClient
    }
    
    func load() async {
        if case .loaded = state { return }
        state = .loading
        
        let symbol = stock.symbol
        async let quoteRequest = finnhubClient.fetchQuote(symbol: symbol)
        async let profileRequest = try? finnhubClient.fetchCompanyProfile(symbol: symbol)
        async let metricsRequest = try? finnhubClient.fetchMetrics(symbol: symbol)
        
        do {
            let quote = try await quoteRequest
            let profile = await profileRequest
            let metrics = await metricsRequest
            guard quote.currentPrice > 0 else {
                state = .failed("No quote is available for \(symbol).")
                return
            }
            state = .loaded(StockDetailContent(
                quote: quote,
                logoURL: profile?.logoURL,
                metrics: metrics
            ))
        } catch is CancellationError {
        } catch let error as URLError where error.code == .cancelled {
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}

extension CompanyProfile {
    var logoURL: URL? {
        guard let logo, !logo.isEmpty else {return nil}
        return URL(string: logo)
    }
}


