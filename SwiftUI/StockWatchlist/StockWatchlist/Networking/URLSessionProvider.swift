//
//  URLSessionProvider.swift
//  StockWatchlist
//

import Foundation

protocol URLSessionProvider {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProvider {}
