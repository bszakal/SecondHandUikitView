//
//  CreateAnnounceCoordinator.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 16/12/22.
//

import Foundation
import SwiftUI
import UIKit

class CreateAnnounceCoordinator: Coordinator {
    
    var rootViewController = UINavigationController()
    
    func start() {
        let startViewVC = UIHostingController(rootView: StartPageCreateAnnounce())
        rootViewController.viewControllers = [startViewVC]
    }
    
}
