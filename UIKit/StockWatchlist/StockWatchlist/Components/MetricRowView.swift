//
//  MetricRowView.swift
//  StockWatchlist
//

import UIKit

final class MetricRowView: UIView {
    private let labelView = UILabel()
    private let valueView = UILabel()

    init(label: String, value: String, accessibilityIdentifier: String? = nil) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.font = .preferredFont(forTextStyle: .subheadline)
        labelView.textColor = .secondaryLabel
        labelView.text = label
        labelView.isAccessibilityElement = false

        valueView.translatesAutoresizingMaskIntoConstraints = false
        valueView.font = .preferredFont(forTextStyle: .subheadline, weight: .medium)
        valueView.textColor = .label
        valueView.textAlignment = .right
        valueView.text = value
        valueView.isAccessibilityElement = false

        addSubview(labelView)
        addSubview(valueView)

        isAccessibilityElement = true
        accessibilityLabel = "\(label), \(value)"
        self.accessibilityIdentifier = accessibilityIdentifier

        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: topAnchor),
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor),

            valueView.firstBaselineAnchor.constraint(equalTo: labelView.firstBaselineAnchor),
            valueView.leadingAnchor.constraint(greaterThanOrEqualTo: labelView.trailingAnchor, constant: 12),
            valueView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
