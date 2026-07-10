//
//  UIView+TestHelpers.swift
//  StockWatchlistTests
//

import UIKit

extension UIView {
    var isHiddenInHierarchy: Bool {
        var current: UIView? = self
        while let view = current {
            if view.isHidden { return true }
            current = view.superview
        }
        return false
    }

    func firstLabel(withText text: String) -> UILabel? {
        if let label = self as? UILabel, label.text == text {
            return label
        }
        for subview in subviews {
            if let match = subview.firstLabel(withText: text) {
                return match
            }
        }
        return nil
    }

    func firstLabel() -> UILabel? {
        if let label = self as? UILabel {
            return label
        }
        for subview in subviews {
            if let match = subview.firstLabel() {
                return match
            }
        }
        return nil
    }
}
