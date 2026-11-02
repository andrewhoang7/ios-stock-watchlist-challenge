//
//  WatchlistView.swift
//  StockWatchlist
//

import SwiftUI

struct WatchlistView: View {
    @Environment(WatchlistStore.self) private var watchlistStore
    
    let finnhubClient: any FinnhubClientProvider

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
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
                            NavigationLink(value: stock) {
                                ListItemView(
                                    primaryText: stock.name,
                                    secondaryText: stock.symbol,
                                    showsChevron: false,
                                    accessory: StockSymbolAccessoryView(symbol: stock.symbol)
                                )
                                .accessibilityIdentifier(AccessibilityID.stockRow(symbol: stock.symbol)
                                )
                            }
                        }
                        .onDelete(perform: removeStocks)
                    }
                    .listStyle(.plain)
                    .accessibilityIdentifier(AccessibilityID.watchlistStockList)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityID.watchlistScreen)
            .navigationTitle("Watchlist")
            .navigationDestination(for: StarterStock.self) { stock in
                StockDetailView(stock: stock, finnhubClient: finnhubClient)
            }
        }
    }
    
    private func removeStocks(at offsets: IndexSet) {
        let stocksToRemove = offsets.map { watchlistStore.stocks[$0] }
        stocksToRemove.forEach { watchlistStore.remove($0) }
    }
}

#Preview {
    WatchlistView(finnhubClient: StubbFinnhubClient())
        .environment(WatchlistStore(stocks: [StarterStock(symbol: "AAPL", name: "Apple Inc.")]))
}
