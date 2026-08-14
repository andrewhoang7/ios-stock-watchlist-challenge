//
//  StockDetailSummaryView.swift
//  StockWatchlist
//

import SwiftUI

struct StockDetailSummaryView: View {
    let stock: StarterStock
    let quote: StockQuote
    let logoURL: URL?

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                if let logoURL {
                    AsyncImage(url: logoURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        default:
                            StockSymbolAccessoryView(symbol: stock.symbol)
                        }
                    }
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                } else {
                    StockSymbolAccessoryView(symbol: stock.symbol)
                        .frame(width: 48, height: 48)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(stock.name)
                        .font(.title3.bold())
                    Text(stock.symbol)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }

            VStack(spacing: 8) {
                Text(quote.currentPrice, format: .currency(code: "USD"))
                    .font(.largeTitle.bold())
                    .accessibilityIdentifier(AccessibilityID.stockPrice)

                if Self.shouldShowChange(in: quote), let change = quote.change, let percentText = quote.formattedPercentChange {
                    Text("\(change, format: .currency(code: "USD")) (\(percentText))")
                        .font(.headline)
                        .foregroundStyle(change >= 0 ? .green : .red)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
    }

    static func shouldShowChange(in quote: StockQuote) -> Bool {
        quote.change != nil && quote.percentChange != nil
    }
}

#Preview {
    StockDetailSummaryView(
        stock: StarterStock(symbol: "AAPL", name: "Apple Inc."),
        quote: StockQuote(currentPrice: 310.26, change: -4.94, percentChange: -1.57),
        logoURL: nil
    )
    .padding()
}
