//
//  CardView.swift
//  StockWatchlist
//

import UIKit

final class CardView: UIView {
    private let titleLabel = UILabel()
    private let contentStack = UIStackView()
    private let containerStack = UIStackView()

    init(title: String? = nil, arrangedSubviews: [UIView] = []) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .systemGroupedBackground
        layer.cornerRadius = 12
        layer.cornerCurve = .continuous
        layer.borderWidth = 1
        layer.borderColor = UIColor.separator.cgColor

        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.axis = .vertical
        containerStack.spacing = 12
        containerStack.alignment = .fill
        addSubview(containerStack)

        if let title {
            titleLabel.font = .preferredFont(forTextStyle: .headline)
            titleLabel.textColor = .label
            titleLabel.text = title
            containerStack.addArrangedSubview(titleLabel)
        }

        contentStack.axis = .vertical
        contentStack.spacing = 12
        contentStack.alignment = .fill
        arrangedSubviews.forEach { contentStack.addArrangedSubview($0) }
        containerStack.addArrangedSubview(contentStack)

        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
