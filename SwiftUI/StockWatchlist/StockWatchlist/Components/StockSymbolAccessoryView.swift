//
//  StockSymbolAccessoryView.swift
//  StockWatchlist
//

import SwiftUI

struct StockSymbolAccessoryView: View {
    let symbol: String

    var body: some View {
        Circle()
            .fill(Color.accentColor.opacity(0.15))
            .frame(width: 40, height: 40)
            .overlay {
                Text(String(symbol.prefix(1)))
                    .font(.headline)
                    .foregroundStyle(.tint)
            }
    }
}
