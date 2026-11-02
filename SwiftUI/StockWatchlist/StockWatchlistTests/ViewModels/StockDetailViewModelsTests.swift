//
//  StockDetailViewModelsTests.swift
//  StockWatchlistTests
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation
import XCTest
@testable import StockWatchlist

@MainActor
final class StockDetailViewModelsTests: XCTestCase {
    private let stock = StarterStock(symbol: "AAPL", name: "Apple Inc.")
    
    private func makeViewModel(_ client: MockFinnhubClient = MockFinnhubClient()) -> StockDetailViewModel {
        StockDetailViewModel(stock: stock, finnhubClient: client)
    }
    
    private func failureMessage(_ viewModel: StockDetailViewModel) -> String? {
        guard case let .failed(message) = viewModel.state else {
            XCTFail("Expected failed state, got \(viewModel.state)")
            return nil
        }
        return message
    }
    
    private func loadedContent(_ viewModel: StockDetailViewModel) -> StockDetailContent? {
        guard case let .loaded(content) = viewModel.state else {
            XCTFail("Expected loaded state, got viewModel.state")
            return nil
        }
        return content
    }
    
    func testStartsInLoadingState() {
        let viewModel = makeViewModel()
        
        guard case .loading = viewModel.state else {
            return XCTFail("Expected loading state")
        }
    }
    
    func testLoadSuccessProducesLoadedContent() async {
        let viewModel = makeViewModel()
        await viewModel.load()
        let content = loadedContent(viewModel)
        XCTAssertEqual(content?.quote.currentPrice, 100)
        XCTAssertEqual(content?.logoURL, URL(string: "https://example.com/logo.png"))
        XCTAssertEqual(content?.metrics?.week52High, 200)
    }
    
    func testQuoteFailuresProducesFailedState() async {
        let client = MockFinnhubClient()
        client.quoteResult = .failure(FinnhubAPIError.rateLimited)
        let viewModel = makeViewModel(client)
        await viewModel.load()
        
        XCTAssertEqual(failureMessage(viewModel), FinnhubAPIError.rateLimited.localizedDescription)
    }
    
    func testProfileFailureStillLoadsWithoutLogo() async {
        let client = MockFinnhubClient()
        client.profileResult = .failure(TestError())
        let viewModel = makeViewModel(client)
        
        await viewModel.load()
        let content = loadedContent(viewModel)
        XCTAssertNotNil(content)
        XCTAssertNil(content?.logoURL)
    }
    
    func testMetricsFailureStillLoadsWithoutMetrics() async {
        let client = MockFinnhubClient()
        client.metricsResult = .failure(TestError())
        let viewModel = makeViewModel(client)
        
        await viewModel.load()
        let content = loadedContent(viewModel)
        XCTAssertNotNil(content)
        XCTAssertNil(content?.metrics)
    }
    
    func testZeroPriceIsTreatedAsUnavailable() async {
        let client = MockFinnhubClient()
        client.quoteResult = .success(StockQuote(currentPrice: 0, change: nil, percentChange: nil))
        let viewModel = makeViewModel(client)
        
        await viewModel.load()
        
        XCTAssertEqual(failureMessage(viewModel), "No quote is available for AAPL.")
    }
    
    func testLoadAgainAfterSuccessNoRefetch() async {
        let client = MockFinnhubClient()
        let viewModel = makeViewModel(client)
        
        await viewModel.load()
        await viewModel.load()
        
        XCTAssertEqual(client.quoteCallCount, 1)
    }
}
