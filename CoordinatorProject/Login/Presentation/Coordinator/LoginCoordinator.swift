//
//  LoginCoordinator.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 15/12/22.
//

import Foundation
import UIKit
import SwiftUI

class LoginCoordinator: Coordinator {
    
    
    var rootViewController = UIViewController()

    func start() {
        self.rootViewController = UIHostingController(rootView: LoginView(registerButtonPressed: {
            self.showRegisterView()
        }, correctProviderNotNil: { provider in
            self.showSignInWithCorrectProviderView(provider: provider)
        }))
    }
    
    func showRegisterView(){
        let registerVc2 = UIHostingController(rootView: RegisterEmailView())
        rootViewController.present(registerVc2, animated: true)
    }
    
    func showSignInWithCorrectProviderView(provider: LoginVM.CorrectProvider){
        let signInwithCorrectProviderVc = UIHostingController(rootView: SignInWithCorrectProviderView(correctProvider: provider))
        rootViewController.present(signInwithCorrectProviderVc, animated: true)
    }

    
}
