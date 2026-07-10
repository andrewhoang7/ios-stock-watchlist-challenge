//
//  StockSymbolAccessoryView.swift
//  StockWatchlist
//

import UIKit

final class StockSymbolAccessoryView: UIView {
    private let letterLabel = UILabel()

    init(symbol: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = UIColor.tintColor.withAlphaComponent(0.15)
        layer.cornerRadius = 20
        clipsToBounds = true

        letterLabel.translatesAutoresizingMaskIntoConstraints = false
        letterLabel.font = .preferredFont(forTextStyle: .headline)
        letterLabel.textColor = UIColor.tintColor
        letterLabel.text = String(symbol.prefix(1))
        letterLabel.textAlignment = .center
        addSubview(letterLabel)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 40),
            heightAnchor.constraint(equalToConstant: 40),
            letterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            letterLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
