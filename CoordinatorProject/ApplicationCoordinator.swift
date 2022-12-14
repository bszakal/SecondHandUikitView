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
    
    let hasSeenOnboarding = CurrentValueSubject<Bool,Never>(false)
    var subscriptions = Set<AnyCancellable>()
    
    let loginState: LoginState
    //var isLoggedIn: Bool = false
    
    init(window: UIWindow, loginState: LoginState) {
        
        self.window = window
        self.loginState = loginState
    }
    
    
    func start() {
        
        //setupOnboardingValue()
        
//        hasSeenOnboarding
//            .removeDuplicates()
//            .sink { [weak self] hasSeen in
//            if hasSeen {
//                let mainCoordinator = MainCoordinator()
//                mainCoordinator.start()
//                self?.childCoordinators = [mainCoordinator]
//                self?.window.rootViewController = mainCoordinator.rootViewController
//            } else if let hasSeenOnboarding = self?.hasSeenOnboarding {
//                let onboardingCoordinator = OnboardingCoordinator(hasSeenOnboarding: hasSeenOnboarding)
//                onboardingCoordinator.start()
//                self?.childCoordinators = [onboardingCoordinator]
//                self?.window.rootViewController = onboardingCoordinator.rootViewController
//            }
//        }
//        .store(in: &subscriptions)
        loginState.$isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoggedIn in
                    //self?.isLoggedIn = isLoggedIn
                if let loginState = self?.loginState{
                    if isLoggedIn{
                        let mainCoordinator = MainCoordinator(loginState: loginState)
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
    
    func setupOnboardingValue() {
        
        // storing and loading of state/data
        
        let key = "hasSeenOnboarding"
        let value = UserDefaults.standard.bool(forKey: key) //default of false
        hasSeenOnboarding.send(value)
        
        hasSeenOnboarding
            .filter({ $0 })
            .sink { (value) in
                UserDefaults.standard.setValue(value, forKey: key)
            }
            .store(in: &subscriptions)
        
    }
    
    
}
