//
//  FinnhubConfiguration.swift
//  StockWatchlist
//

import Foundation

enum FinnhubConfiguration {
    static let baseURL = URL(string: "https://finnhub.io/api/v1")!
    static let testApiKey = "test-key"

    static let uiTestingEnvironmentKey = "UI_TESTING"

    static var isRunningTests: Bool {
        let environment = ProcessInfo.processInfo.environment
        return environment["XCTestConfigurationFilePath"] != nil
            || environment[uiTestingEnvironmentKey] != nil
    }

    static var apiKey: String? {
        guard
            let url = Bundle.main.url(forResource: "Finnhub", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
            let key = plist["FINNHUB_API_KEY"] as? String,
            !key.isEmpty,
            key != "YOUR_API_KEY_HERE"
        else {
            return nil
        }
        return key
    }
}
