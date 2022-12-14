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
    
//    var hasSeenOnboarding: CurrentValueSubject<Bool, Never>
//
//    init(hasSeenOnboarding: CurrentValueSubject<Bool, Never>) {
//        self.hasSeenOnboarding = hasSeenOnboarding
//    }
    
    let loginState: LoginState
    
    init(loginState: LoginState){
        self.loginState = loginState
    }
    
    func start() {
//        let view = OnboardingView { [weak self] in
//            self?.hasSeenOnboarding.send(true)
//        }
        
//        let loginState = LoginState()
//        loginState.isLoggedIn = true
        rootViewController = UIHostingController(rootView: LoginView())
    }
}
