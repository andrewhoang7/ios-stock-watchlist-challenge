//
//  AppDelegate.swift
//  StockWatchlist
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    let watchlistStore = WatchlistStore()
    let catalog = StarterStockCatalog()
    let finnhubClient = FinnhubClient.configured()
    let imageLoader = URLSessionImageLoader()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}
