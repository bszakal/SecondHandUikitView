//
//  ApplicationCoordinator.swift
//  CoordinatorProject
//
//  Created by Karin Prater on 17.04.22.
//

import SwiftUI
import UIKit
import Combine

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    
    var childCoordinators = [Coordinator]()
    
    var subscriptions = Set<AnyCancellable>()
    
    let loginState: LoginState
    @Inject var loginStateUikit: LogginStateUikitProtocol
    
    init(window: UIWindow, loginState: LoginState) {
        
        self.window = window
        self.loginState = loginState
    }
    
    
    func start() {
        
        loginStateUikit.isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoggedIn in
                    //self?.isLoggedIn = isLoggedIn
                if let loginState = self?.loginState{
                    
                    //change to isLoggedIn
                    if true{
                        let mainCoordinator = MainCoordinator()
                        mainCoordinator.start()
                        self?.childCoordinators = [mainCoordinator]
                        self?.window.rootViewController = mainCoordinator.rootViewController
                    } else  {
                        let onboardingCoordinator = OnboardingCoordinator(loginState: loginState)
                        onboardingCoordinator.start()
                        self?.childCoordinators = [onboardingCoordinator]
                        self?.window.rootViewController = onboardingCoordinator.rootViewController
                    }
                }
            }
            .store(in: &subscriptions)
        
        
    }   
}
