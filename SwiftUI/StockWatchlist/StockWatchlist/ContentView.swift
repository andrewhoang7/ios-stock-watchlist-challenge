//
//  ContentView.swift
//  StockWatchlist
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WatchlistView()
                .tabItem {
                    Label {
                        Text("Watchlist")
                            .accessibilityIdentifier(AccessibilityID.watchlistTab)
                    } icon: {
                        Image(systemName: "star.fill")
                    }
                }

            StockBrowseView()
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
    ContentView()
        .environment(WatchlistStore())
}
