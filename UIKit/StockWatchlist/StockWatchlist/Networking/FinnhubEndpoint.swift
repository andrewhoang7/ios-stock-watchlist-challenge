//
//  FinnhubEndpoint.swift
//  StockWatchlist
//

import Foundation

enum FinnhubEndpoint {
    case quote(symbol: String)
    case companyProfile(symbol: String)
    case stockMetrics(symbol: String)

    var path: String {
        switch self {
        case .quote:
            "/quote"
        case .companyProfile:
            "/stock/profile2"
        case .stockMetrics:
            "/stock/metric"
        }
    }

    func queryItems(apiKey: String) -> [URLQueryItem] {
        var items = [URLQueryItem(name: "token", value: apiKey)]

        switch self {
        case let .quote(symbol):
            items.append(URLQueryItem(name: "symbol", value: symbol))
        case let .companyProfile(symbol):
            items.append(URLQueryItem(name: "symbol", value: symbol))
        case let .stockMetrics(symbol):
            items.append(URLQueryItem(name: "symbol", value: symbol))
            items.append(URLQueryItem(name: "metric", value: "all"))
        }

        return items
    }
}
