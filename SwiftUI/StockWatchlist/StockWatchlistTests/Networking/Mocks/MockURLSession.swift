//
//  MockURLSession.swift
//  StockWatchlistTests
//

import Foundation
@testable import StockWatchlist

final class MockURLSession: URLSessionProvider {
    private let onRequest: (URLRequest) throws -> (Data, URLResponse)

    init(onRequest: @escaping (URLRequest) throws -> (Data, URLResponse)) {
        self.onRequest = onRequest
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try onRequest(request)
    }
}
