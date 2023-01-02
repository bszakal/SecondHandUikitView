//
//  FavouriteCoordinator.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 21/12/22.
//
import SwiftUI
import UIKit
import Foundation


class FavouriteCoordinator:NSObject, Coordinator{

    var rootViewController = UINavigationController()
    
    let isLoggedIn: Bool
    let showLoginView: () -> Void
    
    init(isLoggedIn: Bool, showLoginView: @escaping ()->Void ){
        self.isLoggedIn = isLoggedIn
        self.showLoginView = showLoginView
        
        super.init()
        rootViewController.delegate = self
    }
    
    func start(){
        let favouriteViewVC = FavouriteViewUikit(router: self)
        rootViewController.pushViewController(favouriteViewVC, animated: false)
    }
}

//MARK: Part to be able to show Detail view

extension FavouriteCoordinator: AnnounceDetailViewDelegate, showChatViewProtocol{
    
    func showChatView(announceId: String, otherUser: UserProfile, currentUser: UserProfile) {
        let chatViewVC = self.getChatViewVC(announceId: announceId, otherUser: otherUser, currentUser: currentUser)
        rootViewController.pushViewController(chatViewVC, animated: true)
    }
    
    func showAnnounceDetailView(announce: Announce){
        let announceDetailedViewVC = self.getAnnounceDetailViewVC(announce: announce)
        rootViewController.pushViewController(announceDetailedViewVC, animated: true)
    }
}

//MARK: - Navigation controller delegate
extension FavouriteCoordinator: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
        if viewController as? FavouriteViewUikit != nil {
            self.rootViewController.tabBarController?.tabBar.isHidden = false
        } else {
            self.rootViewController.tabBarController?.tabBar.isHidden = true
        }
    }
}
