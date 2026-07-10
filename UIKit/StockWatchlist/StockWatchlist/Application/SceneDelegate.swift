//
//  SceneDelegate.swift
//  StockWatchlist
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard
            let windowScene = scene as? UIWindowScene,
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainTabBarController(
            watchlistStore: appDelegate.watchlistStore,
            catalog: appDelegate.catalog,
            finnhubClient: appDelegate.finnhubClient,
            imageLoader: appDelegate.imageLoader
        )
        window.makeKeyAndVisible()
        self.window = window
    }
}
