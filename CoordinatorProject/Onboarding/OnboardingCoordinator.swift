//
//  OnboardingCoordinator.swift
//  CoordinatorProject
//
//  Created by Karin Prater on 17.04.22.
//

import Foundation
import SwiftUI
import Combine

class OnboardingCoordinator: Coordinator {
    
    var rootViewController = UIViewController()
    
    let loginState: LoginState
    
    init(loginState: LoginState){
        self.loginState = loginState
    }
    
    func start() {
        rootViewController = UIHostingController(rootView: LoginView())
    }
}
