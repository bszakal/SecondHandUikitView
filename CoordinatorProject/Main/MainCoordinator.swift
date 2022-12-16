//
//  MainCoordinator.swift
//  CoordinatorProject
//
//  Created by Karin Prater on 17.04.22.
//
import Combine
import Foundation
import UIKit
import SwiftUI


class MainCoordinator: Coordinator {
    
    var rootViewController: UITabBarController
    var selectedTab = 0
    //var rootViewController = UIViewController()
    @Inject var loginState: LogginStateUikitProtocol!
    
    var childCoordinators = [Coordinator]()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        self.rootViewController = UITabBarController()
//        rootViewController.tabBar.isTranslucent = false
//        rootViewController.tabBar.isOpaque = true
//        rootViewController.tabBar.backgroundColor = .lightGray
 
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
        //self.rootViewController = UIHostingController(rootView: MainTabView(loginState: loginState))
        
        
        loginState.isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.setupTabBar(isLoggedIn: newValue)
            }
            .store(in: &cancellables)
        
    }
    
    func setupTabBar(isLoggedIn: Bool) {
        
        var arrayVC = [UIViewController]()
        
        let vcAnnounce = UIHostingController(rootView: HomePageView())
        vcAnnounce.tabBarItem = UITabBarItem(title: "Announces", image: UIImage(systemName: "list.bullet.rectangle.fill"), tag: 0)
        
        arrayVC.append(vcAnnounce)
        
        
        if isLoggedIn {

            let vcFavourite = UIHostingController(rootView: FavouriteView())
            vcFavourite.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "heart.fill"), tag: 1)
            arrayVC.append(vcFavourite)
            
            let vcPublish = UIHostingController(rootView: StartPageCreateAnnounce())
            vcPublish.tabBarItem = UITabBarItem(title: "Publish", image: UIImage(systemName: "plus.square.fill"), tag: 2)
            arrayVC.append(vcPublish)
            
            let messageCoordinator = MessageCoordinator()
            messageCoordinator.start()
            messageCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Message", image: UIImage(systemName: "envelope"), tag: 3)
            let vcMessage = messageCoordinator.rootViewController as UIViewController
            arrayVC.append(vcMessage)
            
            //let vcAccount = UIHostingController(rootView: MyAccountView())
            let userCoordinator = UserCoordinator()
            userCoordinator.start()
            userCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.crop.circle.fill"), tag: 4)
            let userVc = userCoordinator.rootViewController as UIViewController
            arrayVC.append(userVc)
            
        } else {

            let vcFavourite = UIHostingController(rootView: LoginRestrictedView(title: "Favourites"){
                self.showLoginView()
            })
            vcFavourite.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "heart.fill"), tag: 1)
            arrayVC.append(vcFavourite)
            
            let vcPublish = UIHostingController(rootView: LoginRestrictedView(title: "Publish"){
                self.showLoginView()
            })
            vcPublish.tabBarItem = UITabBarItem(title: "Publish", image: UIImage(systemName: "plus.square.fill"), tag: 2)
            arrayVC.append(vcPublish)
            
            let vcMessage = UIHostingController(rootView: LoginRestrictedView(title: "Messages"){
                self.showLoginView()
            })
            vcMessage.tabBarItem = UITabBarItem(title: "Message", image: UIImage(systemName: "envelope"), tag: 3)
            arrayVC.append(vcMessage)
            
            let vcAccount = UIHostingController(rootView: LoginRestrictedView(title: "My Account"){
                self.showLoginView()
            })
            vcAccount.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.crop.circle.fill"), tag: 4)
            arrayVC.append(vcAccount)
        }
        
        self.rootViewController.viewControllers = arrayVC
        
    }
    
    func showLoginView(){
        let loginCoordinator = LoginCoordinator()
        loginCoordinator.start()
        rootViewController.present(loginCoordinator.rootViewController, animated: true)
    }

}

