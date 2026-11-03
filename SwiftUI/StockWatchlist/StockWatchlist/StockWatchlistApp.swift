//
//  StockWatchlistApp.swift
//  StockWatchlist
//

import SwiftUI

@main
struct StockWatchlistApp: App {
    @State private var watchlistStore = WatchlistStore()
    private let finnhubClient = FinnhubClientFactory.make()

    var body: some Scene {
        WindowGroup {
            ContentView(finnhubClient: finnhubClient)
                .environment(watchlistStore)
        }
    }
}
