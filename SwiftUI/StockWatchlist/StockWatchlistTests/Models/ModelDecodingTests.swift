//
//  ModelDecodingTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class ModelDecodingTests: XCTestCase {
    func testDecodesStockQuoteFromFinnhubPayload() throws {
        let data = Data(#"{"c":308.63,"d":14.25,"dp":4.8407}"#.utf8)

        let quote = try JSONDecoder().decode(StockQuote.self, from: data)

        XCTAssertEqual(quote.currentPrice, 308.63)
        XCTAssertEqual(quote.change, 14.25)
        XCTAssertEqual(quote.percentChange, 4.8407)
    }

    func testDecodesCompanyProfileFromFinnhubPayload() throws {
        let data = Data(#"{"logo":"https://static.finnhub.io/logo/example.png"}"#.utf8)

        let profile = try JSONDecoder().decode(CompanyProfile.self, from: data)

        XCTAssertEqual(profile.logo, "https://static.finnhub.io/logo/example.png")
    }

    func testDecodesStockMetricsFromFinnhubPayload() throws {
        let data = Data(
            #"{"metric":{"52WeekHigh":260.1,"52WeekLow":169.21,"dividendYieldIndicatedAnnual":0.44}}"#.utf8
        )

        let response = try JSONDecoder().decode(StockMetricsResponse.self, from: data)

        XCTAssertEqual(response.metric.week52High, 260.1)
        XCTAssertEqual(response.metric.week52Low, 169.21)
        XCTAssertEqual(response.metric.annualDividendYield, 0.44)
    }

    func testDecodesStarterStockArray() throws {
        let data = Data(
            "[{\"symbol\":\"AAPL\",\"name\":\"Apple Inc.\"},{\"symbol\":\"MSFT\",\"name\":\"Microsoft Corporation\"}]".utf8
        )

        let stocks = try JSONDecoder().decode([StarterStock].self, from: data)

        XCTAssertEqual(stocks.count, 2)
        XCTAssertEqual(stocks[0].id, "AAPL")
    }
}
