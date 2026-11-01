//
//  StockBrowseView.swift
//  StockWatchlist
//

import SwiftUI

struct StockBrowseView: View {
//    private let catalog: StarterStockCatalog
    private let stocks: [StarterStock]
    init(catalog: StarterStockCatalogProvider = StarterStockCatalog()) {
        self.stocks = catalog.load()
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
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(AccessibilityID.browseScreen)
            .navigationTitle("Browse")
            .navigationDestination(for: StarterStock.self) { stock in Text(stock.name)
            }
        }
    }
}

//            Color.clear
//                .accessibilityIdentifier("browse-screen")
//                .navigationTitle("Browse")

#Preview {
    StockBrowseView()
}
