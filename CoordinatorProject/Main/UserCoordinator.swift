//
//  UserCoordinator.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 15/12/22.
//

import Foundation
import SwiftUI
import UIKit


class UserCoordinator: Coordinator{
    
    var rootViewController = UINavigationController()
    
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
        let userProfileVc = UIHostingController(rootView: UserProfileView{
            self.rootViewController.tabBarController?.tabBar.isHidden = false
        })
        rootViewController.tabBarController?.tabBar.isHidden = true
        rootViewController.pushViewController(userProfileVc, animated: true)
    }
    
    func showFavourite(){
        let favouriteVc = UIHostingController(rootView: FavouriteView())
        rootViewController.pushViewController(favouriteVc, animated: true)
    }
    
    func showMyAnnounces(){
        let myAnnouncesVC = UIHostingController(rootView: MyAnnouncesView(DetailViewRequested: {
            self.showAnnounceDetailView()
        }, completionHandler: {
            self.rootViewController.tabBarController?.tabBar.isHidden = false
        }))
        rootViewController.tabBarController?.tabBar.isHidden = true
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
