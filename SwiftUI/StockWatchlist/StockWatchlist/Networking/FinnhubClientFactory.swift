//
//  FinnhubClientFactory.swift
//  StockWatchlist
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation

enum FinnhubClientFactory {
    static func make(environment: [String: String] = ProcessInfo.processInfo.environment) -> any FinnhubClientProvider {
        if environment[FinnhubConfiguration.uiTestingEnvironmentKey] != nil {
            return StubbFinnhubClient()
        }
        return FinnhubClient.configured()
    }
}
