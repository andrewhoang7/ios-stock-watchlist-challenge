//
//  StockBrowseView.swift
//  StockWatchlist
//

import SwiftUI

struct StockBrowseView: View {
    private let stocks: [StarterStock]
    private let finnhubClient: any FinnhubClientProvider
    init(catalog: StarterStockCatalogProvider = StarterStockCatalog(), finnhubClient: any FinnhubClientProvider) {
        self.stocks = catalog.load()
        self.finnhubClient = finnhubClient
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section {
                        ForEach(stocks) { stock in
                            NavigationLink(value: stock) {
                                ListItemView(primaryText: stock.name,
                                             secondaryText: stock.symbol,
                                             accessory: StockSymbolAccessoryView(symbol: stock.symbol)
                                )
                            }
                            .accessibilityIdentifier(AccessibilityID.stockRow(symbol: stock.symbol))

                            }
                    } header: {
                        Text("\(stocks.count) Stocks")
                        .accessibilityIdentifier(AccessibilityID.browseStockCountHeader)
                    }
                }
                .listStyle(.plain)
                .accessibilityIdentifier(AccessibilityID.browseStockList)
            }
            .navigationTitle("Browse")
            .navigationDestination(for: StarterStock.self) { stock in
                StockDetailView(stock: stock,
                                finnhubClient: finnhubClient
                )
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(AccessibilityID.browseScreen)
    }
}

#Preview {
    StockBrowseView(finnhubClient: StubbFinnhubClient())
        .environment(WatchlistStore())
}
