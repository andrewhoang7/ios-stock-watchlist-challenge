//
//  StockDetailSummaryView.swift
//  StockWatchlist
//

import UIKit

final class StockDetailSummaryView: UIView {
    private let logoContainer = UIView()
    private let logoImageView = UIImageView()
    private let nameLabel = UILabel()
    private let symbolLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }

    func configure(stock: StarterStock, quote: StockQuote, logo: UIImage?) {
        nameLabel.text = stock.name
        symbolLabel.text = stock.symbol

        priceLabel.text = quote.currentPrice.formatted(.currency(code: "USD"))
        priceLabel.accessibilityIdentifier = AccessibilityID.stockPrice

        if let change = quote.change, let percentText = quote.formattedPercentChange {
            let changeText = change.formatted(.currency(code: "USD"))
            changeLabel.text = "\(changeText) (\(percentText))"
            changeLabel.textColor = change >= 0 ? .systemGreen : .systemRed
            changeLabel.isHidden = false
        } else {
            changeLabel.isHidden = true
        }

        displayLogo(image: logo, symbol: stock.symbol)
    }

    var displayedName: String? { nameLabel.text }
    var displayedSymbol: String? { symbolLabel.text }
    var displayedPrice: String? { priceLabel.text }
    var displayedChange: String? { changeLabel.text }
    var isChangeVisible: Bool { !changeLabel.isHidden }

    private func setUpViews() {
        translatesAutoresizingMaskIntoConstraints = false

        logoContainer.translatesAutoresizingMaskIntoConstraints = false

        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 24
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = .preferredFont(forTextStyle: .title3, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 0

        symbolLabel.font = .preferredFont(forTextStyle: .subheadline)
        symbolLabel.textColor = .secondaryLabel

        let titleStack = UIStackView(arrangedSubviews: [nameLabel, symbolLabel])
        titleStack.axis = .vertical
        titleStack.spacing = 4
        titleStack.alignment = .leading

        let headerStack = UIStackView(arrangedSubviews: [logoContainer, titleStack])
        headerStack.axis = .horizontal
        headerStack.spacing = 12
        headerStack.alignment = .center

        priceLabel.font = .preferredFont(forTextStyle: .largeTitle, weight: .bold)
        priceLabel.textAlignment = .center

        changeLabel.font = .preferredFont(forTextStyle: .headline)
        changeLabel.textAlignment = .center

        let priceStack = UIStackView(arrangedSubviews: [priceLabel, changeLabel])
        priceStack.axis = .vertical
        priceStack.spacing = 8
        priceStack.alignment = .fill

        let rootStack = UIStackView(arrangedSubviews: [headerStack, priceStack])
        rootStack.translatesAutoresizingMaskIntoConstraints = false
        rootStack.axis = .vertical
        rootStack.spacing = 16
        addSubview(rootStack)

        NSLayoutConstraint.activate([
            logoContainer.widthAnchor.constraint(equalToConstant: 48),
            logoContainer.heightAnchor.constraint(equalToConstant: 48),

            rootStack.topAnchor.constraint(equalTo: topAnchor),
            rootStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func displayLogo(image: UIImage?, symbol: String) {
        logoContainer.subviews.forEach { $0.removeFromSuperview() }

        if let image {
            logoImageView.image = image
            logoImageView.isHidden = false
            logoContainer.addSubview(logoImageView)
            NSLayoutConstraint.activate([
                logoImageView.topAnchor.constraint(equalTo: logoContainer.topAnchor),
                logoImageView.leadingAnchor.constraint(equalTo: logoContainer.leadingAnchor),
                logoImageView.trailingAnchor.constraint(equalTo: logoContainer.trailingAnchor),
                logoImageView.bottomAnchor.constraint(equalTo: logoContainer.bottomAnchor)
            ])
            return
        }

        logoImageView.isHidden = true
        let accessory = StockSymbolAccessoryView(symbol: symbol)
        accessory.translatesAutoresizingMaskIntoConstraints = false
        logoContainer.addSubview(accessory)
        NSLayoutConstraint.activate([
            accessory.centerXAnchor.constraint(equalTo: logoContainer.centerXAnchor),
            accessory.centerYAnchor.constraint(equalTo: logoContainer.centerYAnchor)
        ])
    }
}
