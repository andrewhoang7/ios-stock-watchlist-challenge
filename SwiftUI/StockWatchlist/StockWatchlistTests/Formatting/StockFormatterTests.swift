//
//  StockFormatterTests.swift
//  StockWatchlistTests
//
//  Created by Andrew Hoang on 11/1/26.
//

import Foundation
import XCTest
@testable import StockWatchlist

final class StockFormattertTests: XCTestCase {
    func testlogoURLParsesValidString() {
        let profile = CompanyProfile(logo: "https://static.finnhub.io/logo/aapl.png")
        
        XCTAssertEqual(profile.logoURL, URL(string: "https://static.finnhub.io/logo/aapl.png"))
    }
    
    func testLogoURLIsNilForEmpty() {
        XCTAssertNil(CompanyProfile(logo: nil).logoURL)
    }
    
    func testLogoURLIsMissingLogo() {
        XCTAssertNil(CompanyProfile(logo: "").logoURL)
    }
    
    func testPriceFormatsUSD() {
        XCTAssertEqual(StockFormatter.price(260.1), 260.1.formatted(.currency(code: "USD")))
    }
    
    func testPercentTreatsFinnhubValueAsPercentage() {
        let expected = (0.44 / 100).formatted(.percent.precision(.fractionLength(2)))
        let wrong = 0.44.formatted(.percent.precision(.fractionLength(2)))
        
        XCTAssertEqual(StockFormatter.percent(0.44), expected)
        XCTAssertNotEqual(StockFormatter.percent(0.44), wrong)
    }
    
    func testPercentUsesPlaceHolderWhenMissing() {
        XCTAssertEqual(StockFormatter.percent(nil), "-")
    }
}

extension CompanyProfile {
    var logoURL: URL? {
        guard let logo, !logo.isEmpty else {return nil}
        return URL(string: logo)
    }
}
