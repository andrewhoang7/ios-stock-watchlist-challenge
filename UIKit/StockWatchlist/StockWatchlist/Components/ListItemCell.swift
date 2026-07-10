//
//  ListItemCell.swift
//  StockWatchlist
//

import UIKit

final class ListItemCell: UITableViewCell {
    static let reuseIdentifier = "ListItemCell"

    private let listItemView = ListItemView()
    private var onActivateHandler: (() -> Void)?

    var displayedPrimaryText: String? { listItemView.displayedPrimaryText }
    var displayedSecondaryText: String? { listItemView.displayedSecondaryText }
    var isChevronVisible: Bool { listItemView.isChevronVisible }
    var isAccessoryVisible: Bool { listItemView.isAccessoryVisible }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        backgroundColor = .systemBackground

        listItemView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listItemView)

        NSLayoutConstraint.activate([
            listItemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            listItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            listItemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func accessibilityActivate() -> Bool {
        if let onActivateHandler {
            onActivateHandler()
            return true
        }
        return super.accessibilityActivate()
    }

    func configure(
        primaryText: String,
        secondaryText: String?,
        showsChevron: Bool,
        symbol: String?,
        rowAccessibilityIdentifier: String? = nil,
        isTappable: Bool = false,
        onActivate: (() -> Void)? = nil
    ) {
        onActivateHandler = onActivate
        selectionStyle = isTappable ? .default : .none

        let accessory = symbol.map { StockSymbolAccessoryView(symbol: $0) }
        listItemView.configure(
            primaryText: primaryText,
            secondaryText: secondaryText,
            showsChevron: showsChevron,
            accessory: accessory
        )

        if let rowAccessibilityIdentifier {
            isAccessibilityElement = true
            accessibilityIdentifier = rowAccessibilityIdentifier
            accessibilityLabel = primaryText
            accessibilityTraits = isTappable ? .button : .staticText
        } else {
            isAccessibilityElement = false
            accessibilityIdentifier = nil
            accessibilityLabel = nil
            accessibilityTraits = .none
        }
    }
}
