//
//  URLSessionImageLoader.swift
//  StockWatchlist
//

import UIKit

struct URLSessionImageLoader: ImageLoaderProvider {
    private let session: any URLSessionProvider

    init(session: any URLSessionProvider = URLSession.shared) {
        self.session = session
    }

    func loadImage(from url: URL) async -> UIImage? {
        do {
            let (data, response) = try await session.data(for: URLRequest(url: url))
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let image = UIImage(data: data)
            else {
                return nil
            }
            return image
        } catch {
            return nil
        }
    }
}
