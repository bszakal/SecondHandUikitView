//
//  SceneDelegate.swift
//  CoordinatorProject
//
//  Created by Karin Prater on 17.04.22.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var mainCoordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let mainCoordinator = MainCoordinator(window: window)
            mainCoordinator.start()
            self.mainCoordinator = mainCoordinator
            
            window.makeKeyAndVisible()
        }
        
    }




}

