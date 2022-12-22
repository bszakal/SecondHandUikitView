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
    
    let window: UIWindow
    
    var rootViewController: UITabBarController
    @Inject var loginState: LogginStateUikitProtocol!
    
    var childCoordinators = [Coordinator]()
    
    var cancellables = Set<AnyCancellable>()
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UITabBarController()
        self.window.rootViewController = self.rootViewController
        
    }
    
    func start() {
        
        loginState.isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.setupTabBar(isLoggedIn: newValue)
            }
            .store(in: &cancellables)
        
       
    }
    
    func setupTabBar(isLoggedIn: Bool) {
        
        var arrayVC = [UIViewController]()
        
        let getAnnounceCoordinator = GetAnnounceCoordinator(isLoggedIn: isLoggedIn, showLoginView:{
            self.showLoginView()
        })
        
        getAnnounceCoordinator.start()
        getAnnounceCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Announces", image: UIImage(systemName: "list.bullet.rectangle.fill"), tag: 0)
        let vcGetAnnounce = getAnnounceCoordinator.rootViewController as UIViewController
        arrayVC.append(vcGetAnnounce)
        //self.childCoordinators.append(getAnnounceCoordinator)
        
        
        if isLoggedIn {
            
            let favouriteCoordinator = FavouriteCoordinator(isLoggedIn: isLoggedIn) {
                self.showLoginView()
            }
            
            favouriteCoordinator.start()
            favouriteCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "heart.fill"), tag: 1)
            let vcFavourite = favouriteCoordinator.rootViewController as UIViewController
            arrayVC.append(vcFavourite)
            //self.childCoordinators.append(favouriteCoordinator)
            
            let createAnnounceCoordinator = CreateAnnounceCoordinator()
            createAnnounceCoordinator.start()
            createAnnounceCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Publish", image: UIImage(systemName: "plus.square.fill"), tag: 2)
            let vcCreateAnnounce = createAnnounceCoordinator.rootViewController as UIViewController
            arrayVC.append(vcCreateAnnounce)
           // self.childCoordinators.append(createAnnounceCoordinator)
            
            let messageCoordinator = MessageCoordinator()
            messageCoordinator.start()
            messageCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Message", image: UIImage(systemName: "envelope"), tag: 3)
            let vcMessage = messageCoordinator.rootViewController as UIViewController
            arrayVC.append(vcMessage)
            //self.childCoordinators.append(messageCoordinator)
            
            let userCoordinator = UserCoordinator(isLoggedIn: isLoggedIn) {
                self.showLoginView()
            }
            userCoordinator.start()
            userCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.crop.circle.fill"), tag: 4)
            let userVc = userCoordinator.rootViewController as UIViewController
            arrayVC.append(userVc)
            //self.childCoordinators.append(userCoordinator)
            
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
        let loginCoordinator = childCoordinators.compactMap{$0 as? LoginCoordinator}
        if loginCoordinator.isEmpty{
            let loginCoordinator = LoginCoordinator()
            loginCoordinator.start()
            rootViewController.present(loginCoordinator.rootViewController, animated: true)
            childCoordinators.append(loginCoordinator)
        } else {
            loginCoordinator[0].start()
            rootViewController.present(loginCoordinator[0].rootViewController, animated: true)
        }
    }
}


