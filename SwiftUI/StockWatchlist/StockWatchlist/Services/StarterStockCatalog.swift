//
//  StarterStockCatalog.swift
//  StockWatchlist
//

import Foundation

struct StarterStockCatalog: StarterStockCatalogProvider {
    let bundle: Bundle
    let resourceName: String

    init(bundle: Bundle = .main, resourceName: String = "StarterStocks") {
        self.bundle = bundle
        self.resourceName = resourceName
    }

    func load() -> [StarterStock] {
        guard let url = bundle.url(forResource: resourceName, withExtension: "json") else {
            fatalError("\(resourceName).json was not found in the app bundle.")
        }

        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("Failed to read \(resourceName).json: \(error)")
        }

        do {
            return try JSONDecoder().decode([StarterStock].self, from: data)
        } catch {
            fatalError("Failed to decode starter stocks: \(error)")
        }
    }
}
