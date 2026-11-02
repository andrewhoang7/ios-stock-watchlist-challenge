//
//  StockDetailView.swift
//  StockWatchlist
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation
import SwiftUI

struct StockDetailView: View {
    @Environment(WatchlistStore.self) private var watchlistStore
    @State private var viewModel: StockDetailViewModel
    
    init(stock: StarterStock, finnhubClient: any FinnhubClientProvider) {
        _viewModel = State(initialValue: StockDetailViewModel(
            stock: stock,
            finnhubClient: finnhubClient))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(AccessibilityID.stockDetailScreen)
        .navigationTitle(viewModel.stock.symbol)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                watchlistButton
            }
        }
        .task {
            await viewModel.load()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading...")
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .accessibilityIdentifier(AccessibilityID.detailLoading)

        case let .failed(message):
            ContentUnavailableView {
                Label("Couldn't load \(viewModel.stock.symbol)",
                      systemImage: "exclamationmark.triangle")
            } description : {
                Text(message)
            } actions: {
                Button("Try Again") {
                    Task {
                        await viewModel.load()
                    }
                }
            }
        case let .loaded(detail):
            ScrollView {
                VStack(spacing: 24) {
                    StockDetailSummaryView(stock: viewModel.stock,
                                           quote: detail.quote,
                                           logoURL: detail.logoURL
                    )
                    keyMetricsCard(detail.metrics)
                }
                .padding()
            }
        }
    }
    
    private func keyMetricsCard(_ metrics: StockMetrics?) -> some View {
        CardView(title: "Key Metrics") {
            MetricRowView(label: "52-week high",
                          value: StockFormatter.price(metrics?.week52High),
                          accessibilityIdentifier: AccessibilityID.metricWeek52High
            )
            MetricRowView(label: "52-week low",
                          value: StockFormatter.price(metrics?.week52Low),
                          accessibilityIdentifier: AccessibilityID.metricWeek52Low
            )
            MetricRowView(label: "Dividend yield",
                          value: StockFormatter.price(metrics?.annualDividendYield),
                          accessibilityIdentifier: AccessibilityID.metricDividendYield
            )
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(AccessibilityID.keyMetricsCard)
    }
    
    private var watchlistButton: some View {
        let isInWatchList = watchlistStore.contains(viewModel.stock)
        return Button {
            watchlistStore.toggle(viewModel.stock)
        } label: {
            Label(isInWatchList ? "Remove from Watchlist" : "Add to Watchlist",
                  systemImage: isInWatchList ? "star.fill" : "star"
            )
        }
        .accessibilityIdentifier(AccessibilityID.watchlistToggle)
    }
}

#Preview {
    NavigationStack {
        StockDetailView(stock: StarterStock(symbol: "AAPL", name: "Apple Inc."),
                        finnhubClient: StubbFinnhubClient()
        )
    }
    .environment(WatchlistStore())
}
