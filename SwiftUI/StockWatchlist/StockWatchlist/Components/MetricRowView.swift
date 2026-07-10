//
//  MetricRowView.swift
//  StockWatchlist
//

import SwiftUI

struct MetricRowView: View {
    let label: String
    let value: String
    var accessibilityIdentifier: String? = nil

    var body: some View {
        let row = HStack(alignment: .firstTextBaseline) {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer(minLength: 12)
            Text(value)
                .font(.subheadline.weight(.medium))
                .multilineTextAlignment(.trailing)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Self.accessibilityLabel(label: label, value: value))

        if let accessibilityIdentifier {
            row.accessibilityIdentifier(accessibilityIdentifier)
        } else {
            row
        }
    }

    static func accessibilityLabel(label: String, value: String) -> String {
        "\(label), \(value)"
    }
}

#Preview {
    VStack(spacing: 12) {
        MetricRowView(label: "52-week high", value: "$315.45")
        MetricRowView(label: "Market cap", value: "$4.55T")
    }
    .padding()
}
