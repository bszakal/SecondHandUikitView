//
//  MainCoordinator.swift
//  CoordinatorProject
//
//  Created by Karin Prater on 17.04.22.
//

import Foundation
import UIKit
import SwiftUI

class MainCoordinator: Coordinator {
    
    //var rootViewController: UITabBarController
    var rootViewController = UIViewController()
    let loginState: LoginState
    
    var childCoordinators = [Coordinator]()
    
    init(loginState: LoginState) {
//        self.rootViewController = UITabBarController()
//        rootViewController.tabBar.isTranslucent = true
//        rootViewController.tabBar.backgroundColor = .lightGray
        self.loginState = loginState
    }
    
    func start() {
        
//        let firstCoordinator = FirstTabCoodinator()
//        firstCoordinator.start()
//        self.childCoordinators.append(firstCoordinator)
//        let firstViewController = firstCoordinator.rootViewController
//        setup(vc: firstViewController,
//              title: "First Tab",
//              imageName: "paperplane",
//              selectedImageName: "paperplane.fill")
//
//
//        let secondCoordinator = SecondTabCoodinator()
//        secondCoordinator.start()
//        self.childCoordinators.append(secondCoordinator)
//        let secondViewController = secondCoordinator.rootViewController
//        setup(vc: secondViewController,
//              title: "Second Tab",
//              imageName: "bell",
//              selectedImageName: "bell.fill")
        
        
        //self.rootViewController.viewControllers = [firstViewController, secondViewController]
        self.rootViewController = UIHostingController(rootView: MainTabView(loginState: loginState))
    }
    
    func setup(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
    }
}
