//
//  GetAnnounceCoordinator.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 18/12/22.
//
import SwiftUI
import UIKit
import Foundation


class GetAnnounceCoordinator:NSObject, Coordinator {

    var rootViewController = UINavigationController()
    let isLoggedIn: Bool
    let showLoginView: ()->Void
 
    
    init(isLoggedIn: Bool, showLoginView: @escaping ()->Void){
        self.isLoggedIn = isLoggedIn
        self.showLoginView = showLoginView
        
        super.init()
        self.rootViewController.delegate = self
    }
        
    func start(){
      //  let homePageVC = UIHostingController(rootView: HomePageView2(delegate: self))
//        let homePageVC = HomePageUikitTest(coordinator: self)
        let homePageVC = HomePageUIkit(coordinator: self)
        rootViewController.pushViewController(homePageVC, animated: false)
    }
    
    func ShowFilteredAnnounces(searchText: String, category: String, minPrice: Double, maxPrice: Double, noOlderThanDate: Date? ){
        if let searchDate = noOlderThanDate{
            
            let announceViewVC = AnnouncesListViewUikit(coordinator: self, isSearchFiltered: true, searchText: searchText, category: category, minPrice: minPrice, maxPrice: maxPrice, noOlderThanDate: searchDate)
            rootViewController.pushViewController(announceViewVC, animated: true)
            
        } else {
            
            let announceViewVC = AnnouncesListViewUikit(coordinator: self, isSearchFiltered: true, searchText: searchText, category: category, minPrice: minPrice, maxPrice: maxPrice)
            rootViewController.pushViewController(announceViewVC, animated: true)
            
        }
    }
    
    func showFilterView(){
        let searchViewVC = UIHostingController(rootView: SearchFilterView2(delegate: self, callbackIfCancelled: {
            self.rootViewController.popViewController(animated: false)
        }))
        self.rootViewController.pushViewController(searchViewVC, animated: false)
    }
   
}
//MARK: - AnnounceDetailedView delegate
extension GetAnnounceCoordinator: AnnounceDetailViewDelegate, showChatViewProtocol{
    func showChatView(announceId: String, otherUser: UserProfile, currentUser: UserProfile){
        let chatViewVC = self.getChatViewVC(announceId: announceId, otherUser: otherUser, currentUser: currentUser)
        self.rootViewController.pushViewController(chatViewVC, animated: true)
    }
    
    func showAnnounceDetailView(announce: Announce){
        let announceDetailedViewVC = self.getAnnounceDetailViewVC(announce: announce)
        rootViewController.pushViewController(announceDetailedViewVC, animated: true)
    }
}

//MARK: - Navigation controller delegate
extension GetAnnounceCoordinator: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
        if viewController as? UIHostingController<HomePageView2> != nil {
            self.rootViewController.tabBarController?.tabBar.isHidden = false
        } else {
            self.rootViewController.tabBarController?.tabBar.isHidden = true
        }
    }
}




