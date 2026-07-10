//
//  StockBrowseView.swift
//  StockWatchlist
//

import SwiftUI

struct StockBrowseView: View {
    private let catalog: StarterStockCatalog
    init(catalog: StarterStockCatalog = StarterStockCatalog()) {
        self.catalog = catalog
    }

    var body: some View {
        NavigationStack {
            // TODO
            Color.clear
                .accessibilityIdentifier("browse-screen")
                .navigationTitle("Browse")
        }
    }
}

#Preview {
    StockBrowseView()
}
