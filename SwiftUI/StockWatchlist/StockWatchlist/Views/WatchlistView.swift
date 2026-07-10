//
//  WatchlistView.swift
//  StockWatchlist
//

import SwiftUI

struct WatchlistView: View {
    @Environment(WatchlistStore.self) private var watchlistStore

    var body: some View {
        NavigationStack {
            Group {
                if watchlistStore.stocks.isEmpty {
                    ContentUnavailableView(
                        "No stocks yet",
                        systemImage: "star",
                        description: Text("Browse stocks and add them to your watchlist.")
                    )
                    .accessibilityIdentifier(AccessibilityID.watchlistEmptyState)
                } else {
                    List {
                        ForEach(watchlistStore.stocks) { stock in
                            ListItemView(
                                primaryText: stock.name,
                                secondaryText: stock.symbol,
                                showsChevron: false,
                                accessory: StockSymbolAccessoryView(symbol: stock.symbol)
                            )
                            .accessibilityIdentifier(AccessibilityID.stockRow(symbol: stock.symbol))
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .accessibilityIdentifier(AccessibilityID.watchlistScreen)
            .navigationTitle("Watchlist")
        }
    }
}

#Preview {
    WatchlistView()
        .environment(WatchlistStore())
}
