//
//  ListItemView.swift
//  StockWatchlist
//

import UIKit

final class ListItemView: UIView {
    private let accessoryContainer = UIView()
    private let primaryLabel = UILabel()
    private let secondaryLabel = UILabel()
    private let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    private let textStack = UIStackView()
    private let rowStack = UIStackView()

    var displayedPrimaryText: String? { primaryLabel.text }
    var displayedSecondaryText: String? { secondaryLabel.text }
    var isChevronVisible: Bool { !chevronImageView.isHidden }
    var isAccessoryVisible: Bool { !accessoryContainer.isHidden }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }

    func configure(
        primaryText: String,
        secondaryText: String?,
        showsChevron: Bool,
        accessory: UIView?
    ) {
        primaryLabel.text = primaryText
        secondaryLabel.text = secondaryText
        primaryLabel.accessibilityIdentifier = "PrimaryContent"
        secondaryLabel.accessibilityIdentifier = "SecondaryContent"

        if let secondaryText, !secondaryText.isEmpty {
            secondaryLabel.isHidden = false
            rowStack.alignment = .top
        } else {
            secondaryLabel.isHidden = true
            rowStack.alignment = .center
        }

        accessoryContainer.subviews.forEach { $0.removeFromSuperview() }
        if let accessory {
            accessory.translatesAutoresizingMaskIntoConstraints = false
            accessory.accessibilityIdentifier = "Accessory"
            accessoryContainer.addSubview(accessory)
            NSLayoutConstraint.activate([
                accessory.topAnchor.constraint(equalTo: accessoryContainer.topAnchor),
                accessory.leadingAnchor.constraint(equalTo: accessoryContainer.leadingAnchor),
                accessory.trailingAnchor.constraint(equalTo: accessoryContainer.trailingAnchor),
                accessory.bottomAnchor.constraint(equalTo: accessoryContainer.bottomAnchor)
            ])
            accessoryContainer.isHidden = false
        } else {
            accessoryContainer.isHidden = true
        }

        chevronImageView.isHidden = !showsChevron
    }

    private func setUpViews() {
        translatesAutoresizingMaskIntoConstraints = false
        isAccessibilityElement = false

        rowStack.translatesAutoresizingMaskIntoConstraints = false
        rowStack.axis = .horizontal
        rowStack.spacing = 12
        rowStack.alignment = .center
        addSubview(rowStack)

        accessoryContainer.translatesAutoresizingMaskIntoConstraints = false
        rowStack.addArrangedSubview(accessoryContainer)

        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.alignment = .fill
        textStack.distribution = .fill
        rowStack.addArrangedSubview(textStack)

        primaryLabel.font = .preferredFont(forTextStyle: .body, weight: .semibold)
        primaryLabel.textColor = .label
        primaryLabel.numberOfLines = 0
        textStack.addArrangedSubview(primaryLabel)

        secondaryLabel.font = .preferredFont(forTextStyle: .subheadline)
        secondaryLabel.textColor = .secondaryLabel
        secondaryLabel.numberOfLines = 0
        textStack.addArrangedSubview(secondaryLabel)

        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.tintColor = .tertiaryLabel
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.setContentHuggingPriority(.required, for: .horizontal)
        chevronImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        rowStack.addArrangedSubview(chevronImageView)

        NSLayoutConstraint.activate([
            rowStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            rowStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            rowStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            rowStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 12)
        ])
    }
}
