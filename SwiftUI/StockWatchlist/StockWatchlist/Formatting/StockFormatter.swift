//
//  StockFormatter.swift
//  StockWatchlist
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation

enum StockFormatter {
    static let placeholder = "-"
    
    static func price(_ value: Double?) -> String {
        guard let value else { return placeholder }
        return value.formatted(.currency(code: "USD"))
    }
    
    static func percent(_ value: Double?) -> String {
        guard let value else { return placeholder }
        return (value / 100).formatted(.percent.precision(.fractionLength(2)))
    }
}
