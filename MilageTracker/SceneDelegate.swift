//
//  SceneDelegate.swift
//  MilageTracker
//
//  Created by Uday on 25/08/21.
//

import UIKit
import FirebaseAnalytics

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        Analytics.logEvent("ActiveFromBackground", parameters: ["AppState":"Active from Background"])
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        Analytics.logEvent("MovedToBackground", parameters: ["AppState":"Moved to background"])
    }


}

