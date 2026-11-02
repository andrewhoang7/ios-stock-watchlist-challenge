//
//  StockDetailView.swift
//  StockWatchlist
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation
import SwiftUI

struct StockDetailView: View {
    @State private var viewModel: StockDetailViewModel
    
    init(stock: StarterStock, finnhubClient: any FinnhubClientProvider) {
        _viewModel = State(initialValue: StockDetailViewModel(
            stock: stock,
            finnhubClient: finnhubClient))
    }
    
    var body: some View {
        content
            .navigationTitle(viewModel.stock.symbol)
            .task {
                await viewModel.load()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading")
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .accessibilityIdentifier(AccessibilityID.detailLoading)
        case let .failed(message):
            Text(message)
        case let .loaded(detail):
            ScrollView {
                VStack(spacing: 24) {
                    StockDetailSummaryView(stock: viewModel.stock,
                                           quote: detail.quote,
                                           logoURL: detail.logoURL
                    )
                }
                .padding()
            }
        }
    }
}
