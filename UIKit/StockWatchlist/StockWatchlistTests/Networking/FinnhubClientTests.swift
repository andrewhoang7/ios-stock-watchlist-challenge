//
//  FinnhubClientTests.swift
//  StockWatchlistTests
//

import XCTest
@testable import StockWatchlist

final class FinnhubClientTests: XCTestCase {
    func testConfiguredUsesTestKeyWhenRunningUnderXCTest() {
        XCTAssertTrue(FinnhubConfiguration.isRunningTests)
        _ = FinnhubClient.configured()
    }

    func testFetchQuoteDecodesSuccessfulResponse() async throws {
        let session = MockURLSession { request in
            XCTAssertTrue(request.url?.absoluteString.contains("/quote") == true)
            XCTAssertTrue(request.url?.absoluteString.contains("symbol=AAPL") == true)
            XCTAssertTrue(request.url?.absoluteString.contains("token=test-key") == true)

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            let data = Data(#"{"c":150.25,"d":2.5,"dp":1.69}"#.utf8)
            return (data, response)
        }

        let client = FinnhubClient(apiKey: "test-key", session: session)
        let quote = try await client.fetchQuote(symbol: "AAPL")

        XCTAssertEqual(quote.currentPrice, 150.25)
        XCTAssertEqual(quote.change, 2.5)
        XCTAssertEqual(quote.percentChange, 1.69)
    }

    func testFetchQuoteThrowsRateLimitedOn429() async {
        let session = MockURLSession { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 429,
                httpVersion: nil,
                headerFields: nil
            )!
            return (Data(), response)
        }

        let client = FinnhubClient(apiKey: "test-key", session: session)

        do {
            _ = try await client.fetchQuote(symbol: "AAPL")
            XCTFail("Expected rateLimited error")
        } catch let error as FinnhubAPIError {
            XCTAssertEqual(error, .rateLimited)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchQuoteThrowsDecodingFailedOnInvalidJSON() async {
        let session = MockURLSession { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (Data("{".utf8), response)
        }

        let client = FinnhubClient(apiKey: "test-key", session: session)

        do {
            _ = try await client.fetchQuote(symbol: "AAPL")
            XCTFail("Expected decodingFailed error")
        } catch let error as FinnhubAPIError {
            guard case .decodingFailed = error else {
                XCTFail("Expected decodingFailed, got \(error)")
                return
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchMetricsDecodesMetricFromResponseEnvelope() async throws {
        let session = MockURLSession { request in
            XCTAssertTrue(request.url?.absoluteString.contains("/stock/metric") == true)

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            let data = Data(
                #"{"metric":{"52WeekHigh":200.5,"52WeekLow":150.25,"dividendYieldIndicatedAnnual":1.2}}"#.utf8
            )
            return (data, response)
        }

        let client = FinnhubClient(apiKey: "test-key", session: session)
        let metrics = try await client.fetchMetrics(symbol: "AAPL")

        XCTAssertEqual(metrics.week52High, 200.5)
        XCTAssertEqual(metrics.week52Low, 150.25)
        XCTAssertEqual(metrics.annualDividendYield, 1.2)
    }
}
