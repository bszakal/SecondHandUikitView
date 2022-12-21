//
//  MessageCoordinator.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 15/12/22.
//

import Foundation
import SwiftUI
import UIKit

class MessageCoordinator:NSObject, Coordinator {
    
    var rootViewController = UINavigationController()
    
    func start(){
        let messagesViewVC = UIHostingController(rootView: MessagesView(chatViewSelected: { announceId, OtherUser, CurrentUser in
            self.showChatView(announceId: announceId, otherUser: OtherUser, currentUser: CurrentUser)
        }))
        rootViewController.viewControllers = [messagesViewVC]
        rootViewController.delegate = self
    }
    

}

extension MessageCoordinator: showChatViewProtocol{
    func showChatView(announceId: String, otherUser: UserProfile, currentUser: UserProfile){
        let chatViewVC = self.getChatViewVC(announceId: announceId, otherUser: otherUser, currentUser: currentUser)
        self.rootViewController.pushViewController(chatViewVC, animated: true)
        
    }
}

//MARK: - Navigation controller delegate
extension MessageCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
        if viewController as? UIHostingController<MessagesView> != nil {
            self.rootViewController.tabBarController?.tabBar.isHidden = false
        } else {
            self.rootViewController.tabBarController?.tabBar.isHidden = true
        }
    }
}
