//
//  MessageCoordinator.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 15/12/22.
//

import Foundation
import SwiftUI
import UIKit

class MessageCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    func start(){
        let messagesViewVC = UIHostingController(rootView: MessagesView(chatViewSelected: { announceId, OtherUser, CurrentUser in
            self.showChatView(announceId: announceId, otherUser: OtherUser, currentUser: CurrentUser)
        }))
        rootViewController.viewControllers = [messagesViewVC]
    }
    
    func showChatView(announceId: String, otherUser: UserProfile, currentUser: UserProfile){
        let chatViewVC = UIHostingController(rootView: ChatView(announceId: announceId, otherUser: otherUser, user: currentUser){
           self.rootViewController.tabBarController?.tabBar.isHidden = false
        })
        rootViewController.tabBarController?.tabBar.isHidden = true
        self.rootViewController.pushViewController(chatViewVC, animated: true)
        
    }
}
