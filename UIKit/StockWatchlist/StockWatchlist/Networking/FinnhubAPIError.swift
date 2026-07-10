//
//  FinnhubAPIError.swift
//  StockWatchlist
//

import Foundation

enum FinnhubAPIError: Error, LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case rateLimited
    case httpError(statusCode: Int, message: String?)
    case decodingFailed(underlying: Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "The request URL could not be formed."
        case .invalidResponse:
            "The server returned an unexpected response."
        case .rateLimited:
            "Finnhub rate limit reached (429). Wait a minute and try again."
        case let .httpError(statusCode, message):
            if let message, !message.isEmpty {
                "HTTP \(statusCode): \(message)"
            } else {
                "HTTP \(statusCode)"
            }
        case let .decodingFailed(underlying):
            "Failed to decode response: \(underlying.localizedDescription)"
        }
    }

    static func == (lhs: FinnhubAPIError, rhs: FinnhubAPIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse),
             (.rateLimited, .rateLimited):
            true
        case let (.httpError(lhsCode, lhsMessage), .httpError(rhsCode, rhsMessage)):
            lhsCode == rhsCode && lhsMessage == rhsMessage
        case let (.decodingFailed(lhsError), .decodingFailed(rhsError)):
            lhsError.localizedDescription == rhsError.localizedDescription
        default:
            false
        }
    }
}
