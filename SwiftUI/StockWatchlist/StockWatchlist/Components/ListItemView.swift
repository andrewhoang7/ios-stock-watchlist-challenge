//
//  ListItemView.swift
//  StockWatchlist
//

import SwiftUI

struct ListItemView<Accessory: View>: View {
    private let primaryText: String
    private let secondaryText: String?
    private let showsChevron: Bool
    private let accessory: Accessory

    init(
        primaryText: String,
        secondaryText: String? = nil,
        showsChevron: Bool = false,
        accessory: Accessory
    ) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.showsChevron = showsChevron
        self.accessory = accessory
    }

    private var hasAccessory: Bool {
        Accessory.self != EmptyView.self
    }

    private var hasSecondaryText: Bool {
        guard let secondaryText else { return false }
        return !secondaryText.isEmpty
    }

    var body: some View {
        HStack(alignment: hasSecondaryText ? .top : .center, spacing: 12) {
            if hasAccessory {
                accessory
                    .accessibilityIdentifier("Accessory")
            }

            VStack(alignment: .leading, spacing: hasSecondaryText ? 4 : 0) {
                Text(primaryText)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityIdentifier("PrimaryContent")

                if let secondaryText, !secondaryText.isEmpty {
                    Text(secondaryText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("SecondaryContent")
                }
            }

            if showsChevron {
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.tertiary)
                    .accessibilityHidden(true)
            }
        }
        .padding(.vertical, 16)
        .contentShape(Rectangle())
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .accessibilityElement(children: .combine)
    }
}

extension ListItemView where Accessory == EmptyView {
    init(
        primaryText: String,
        secondaryText: String? = nil,
        showsChevron: Bool = false
    ) {
        self.init(
            primaryText: primaryText,
            secondaryText: secondaryText,
            showsChevron: showsChevron,
            accessory: EmptyView()
        )
    }
}

#Preview("With chevron") {
    ListItemView(
        primaryText: "Apple Inc.",
        secondaryText: "AAPL",
        showsChevron: true
    )
    .padding(.horizontal)
}

#Preview("With accessory") {
    ListItemView(
        primaryText: "Apple Inc.",
        secondaryText: "AAPL",
        showsChevron: true,
        accessory: StockSymbolAccessoryView(symbol: "AAPL")
    )
    .padding(.horizontal)
}
