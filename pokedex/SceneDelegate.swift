//
//  SceneDelegate.swift
//  pokedex
//
//  Created by Hélio Mesquita on 21/05/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow()
        let feedView = UIHostingController(rootView: FeedView())
        let navController = UINavigationController(rootViewController: feedView)
        navController.navigationBar.prefersLargeTitles = true
        feedView.title = "Pokédex"
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
    
}
