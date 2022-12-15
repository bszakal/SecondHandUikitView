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
        let messagesViewVC = UIHostingController(rootView: MessagesView())
        rootViewController.viewControllers = [messagesViewVC]
    }
}
