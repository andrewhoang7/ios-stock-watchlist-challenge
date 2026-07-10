//
//  ImageLoaderProvider.swift
//  StockWatchlist
//

import UIKit

protocol ImageLoaderProvider {
    func loadImage(from url: URL) async -> UIImage?
}
