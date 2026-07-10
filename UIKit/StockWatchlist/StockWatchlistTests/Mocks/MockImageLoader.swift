//
//  MockImageLoader.swift
//  StockWatchlistTests
//

import UIKit
@testable import StockWatchlist

final class MockImageLoader: ImageLoaderProvider {
    var image: UIImage?

    func loadImage(from url: URL) async -> UIImage? {
        image
    }
}
