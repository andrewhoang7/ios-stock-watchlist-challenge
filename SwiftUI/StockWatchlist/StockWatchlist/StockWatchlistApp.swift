//
//  StockWatchlistApp.swift
//  StockWatchlist
//

import SwiftUI

@main
struct StockWatchlistApp: App {
    @State private var watchlistStore = WatchlistStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(watchlistStore)
        }
    }
}
