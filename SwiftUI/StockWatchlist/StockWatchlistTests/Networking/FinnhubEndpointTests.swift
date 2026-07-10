//
//  FinnhubEndpointTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class FinnhubEndpointTests: XCTestCase {
    func testQuotePath() {
        XCTAssertEqual(FinnhubEndpoint.quote(symbol: "AAPL").path, "/quote")
    }

    func testCompanyProfilePath() {
        XCTAssertEqual(FinnhubEndpoint.companyProfile(symbol: "AAPL").path, "/stock/profile2")
    }

    func testStockMetricsPath() {
        XCTAssertEqual(FinnhubEndpoint.stockMetrics(symbol: "AAPL").path, "/stock/metric")
    }

    func testQuoteQueryItemsIncludeTokenAndSymbol() {
        let items = FinnhubEndpoint.quote(symbol: "AAPL").queryItems(apiKey: "test-token")

        XCTAssertEqual(queryValue(named: "token", in: items), "test-token")
        XCTAssertEqual(queryValue(named: "symbol", in: items), "AAPL")
    }

    func testStockMetricsQueryItemsIncludeMetricAll() {
        let items = FinnhubEndpoint.stockMetrics(symbol: "MSFT").queryItems(apiKey: "test-token")

        XCTAssertEqual(queryValue(named: "token", in: items), "test-token")
        XCTAssertEqual(queryValue(named: "symbol", in: items), "MSFT")
        XCTAssertEqual(queryValue(named: "metric", in: items), "all")
    }

    private func queryValue(named name: String, in items: [URLQueryItem]) -> String? {
        items.first(where: { $0.name == name })?.value
    }
}
