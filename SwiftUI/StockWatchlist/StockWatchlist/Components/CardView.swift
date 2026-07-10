//
//  CardView.swift
//  StockWatchlist
//

import SwiftUI

struct CardView<Content: View>: View {
    private let title: String?
    private let content: Content

    init(title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title {
                Text(title)
                    .font(.headline)
            }

            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.systemGroupedBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color(.separator), lineWidth: 1)
        }
    }
}

#Preview {
    CardView(title: "Key metrics") {
        MetricRowView(label: "P/E ratio", value: "37.09")
        MetricRowView(label: "Beta", value: "1.24")
    }
    .padding()
    .background(Color(.systemBackground))
}
