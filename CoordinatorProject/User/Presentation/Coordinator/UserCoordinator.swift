//
//  UserCoordinator.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 15/12/22.
//

import Foundation
import SwiftUI
import UIKit


class UserCoordinator:NSObject, Coordinator{
    
    var rootViewController = UINavigationController()
    
    var isLoggedIn: Bool
    var showLoginView: () -> Void
    
    init(isLoggedIn: Bool, showLoginView: @escaping ()->Void){
        self.isLoggedIn = isLoggedIn
        self.showLoginView = showLoginView
        
        super.init()
        rootViewController.delegate = self
    }

    func start() {
        let myAccountVc = UIHostingController(rootView: MyAccountView(userProfileRequested: {
            self.showUserProfileView()
        }, favouritViewRequested: {
            self.showFavourite()
        }, myAnnouncesViewRequested: {
            self.showMyAnnounces()
        }))
        rootViewController.viewControllers = [myAccountVc]
    }
    
    func showUserProfileView(){
        let userProfileVc = UIHostingController(rootView: UserProfileView())
        rootViewController.pushViewController(userProfileVc, animated: true)
    }
    
    func showFavourite(){
        let favouriteViewVC = FavouriteViewUikit(router: self)
        rootViewController.pushViewController(favouriteViewVC, animated: true)
    }
    
    func showMyAnnounces(){
        let myAnnouncesVC = UIHostingController(rootView: MyAnnouncesView(DetailViewRequested: {
            self.showAnnounceDetailView()
        }))
        rootViewController.pushViewController(myAnnouncesVC, animated: true)
    }
    
    func showAnnounceDetailView(){
        struct tempViewForExample: View{
            var body: some View{
                Text("To do...")
            }
        }
        let tempViewVC = UIHostingController(rootView: tempViewForExample())
        rootViewController.pushViewController(tempViewVC, animated: true)
    }
}

//MARK: - Show Favourite View
extension UserCoordinator: AnnounceDetailViewDelegate, showChatViewProtocol {
    
    func showChatView(announceId: String, otherUser: UserProfile, currentUser: UserProfile) {
        let chatViewVC = self.getChatViewVC(announceId: announceId, otherUser: otherUser, currentUser: currentUser)
        rootViewController.pushViewController(chatViewVC, animated: true)
    }
    
    func showAnnounceDetailView(announce: Announce) {
        let announceDetailViewVC = self.getAnnounceDetailViewVC(announce: announce)
        rootViewController.pushViewController(announceDetailViewVC, animated: true)
    }
}

//MARK: - Navigation controller delegate
extension UserCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
        if viewController as? UIHostingController<MyAccountView> != nil {
            self.rootViewController.tabBarController?.tabBar.isHidden = false
        } else {
            self.rootViewController.tabBarController?.tabBar.isHidden = true
        }
    }
}
