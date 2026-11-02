//
//  ContentView.swift
//  StockWatchlist
//

import SwiftUI

struct ContentView: View {
    let finnhubClient: any FinnhubClientProvider
    
    var body: some View {
        TabView {
            WatchlistView(finnhubClient: finnhubClient)
                .tabItem {
                    Label {
                        Text("Watchlist")
                            .accessibilityIdentifier(AccessibilityID.watchlistTab)
                    } icon: {
                        Image(systemName: "star.fill")
                    }
                }

            StockBrowseView(finnhubClient: finnhubClient)
                .tabItem {
                    Label {
                        Text("Browse")
                            .accessibilityIdentifier(AccessibilityID.browseTab)
                    } icon: {
                        Image(systemName: "list.bullet")
                    }
                }
        }
    }
}

#Preview {
    ContentView(finnhubClient: StubbFinnhubClient())
        .environment(WatchlistStore())
}
