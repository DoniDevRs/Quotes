//
//  SceneDelegate.swift
//  QuotesApp
//
//  Created by Doni Silva on 24/08/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        window?.rootViewController = HomeTabBarController()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Refresh"), object: nil)
    }
    
}

