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
    
    var createAnnounceVM: CreateAnnounceVM?
    
    private var phaseNbre = 0
    
  
    func start() {
        let startViewVC = UIHostingController(rootView: StartPageCreateAnnounce(buttonStartHandler: {
            self.createAnnounceVM = CreateAnnounceVM()
            self.phaseNbre = 1
            
            self.rootViewController.tabBarController?.tabBar.isHidden = true
            self.pushNextView()
        }))
        
        rootViewController.viewControllers = [startViewVC]
      
    }
    
    func pushNextView(){
        if let vm = createAnnounceVM{
            if phaseNbre == 1 {
                let categoryViewVC = UIHostingController(rootView: selectionCategory2(createAnnounceVM: vm, backButtonPressed: {
                    self.decreasePhaseNbre()
                }, forwardButtonPressed: {
                    self.incrementPhaseNbre()
                }, dimissHandler:{
                    self.dismissCreateAnnounce()
                }))
                rootViewController.pushViewController(categoryViewVC, animated: false)
                
                
            } else if phaseNbre == 2 {
                let conditionViewVC = UIHostingController(rootView: SelectionCondition2(createAnnounceVM: vm, backButtonPressed: {
                    self.decreasePhaseNbre()
                }, forwardButtonPressed: {
                    self.incrementPhaseNbre()
                }, dimissHandler:{
                    self.dismissCreateAnnounce()
                }))
                rootViewController.pushViewController(conditionViewVC, animated: false)
                
            } else if phaseNbre == 3 {
                let titleViewVC = UIHostingController(rootView: SelectionTitle2(createAnnounceVM: vm, backButtonPressed: {
                    self.decreasePhaseNbre()
                }, forwardButtonPressed: {
                    self.incrementPhaseNbre()
                }, dimissHandler:{
                    self.dismissCreateAnnounce()
                }))
                rootViewController.pushViewController(titleViewVC, animated: false)
                
            } else if phaseNbre == 4 {
                let addressVC = UIHostingController(rootView: SelectionAddress2(createAnnounce: vm, backButtonPressed: {
                    self.decreasePhaseNbre()
                }, forwardButtonPressed: {
                    self.incrementPhaseNbre()
                }, dimissHandler:{
                    self.dismissCreateAnnounce()
                }))
                rootViewController.pushViewController(addressVC, animated: false)
                
            } else if phaseNbre == 5 {
                let photoVC = UIHostingController(rootView: PhotoUploadSheet2(createAnnounceVM: vm, backButtonPressed: {
                    self.decreasePhaseNbre()
                }, forwardButtonPressed: {
                    self.incrementPhaseNbre()
                }, dimissHandler:{
                    self.dismissCreateAnnounce()
                }))
                rootViewController.pushViewController(photoVC, animated: false)
            }
            
            else if phaseNbre == 6 {
                let recapVC = UIHostingController(rootView: RecapCreateAnnounce2(createAnnounceVM: vm, backButtonPressed: {
                    self.decreasePhaseNbre()
                }, forwardButtonPressed: {
                    self.dismissCreateAnnounce()
                }, dimissHandler:{
                    self.dismissCreateAnnounce()
                }))
                rootViewController.pushViewController(recapVC, animated: false)
            }
        }
    }
                
    func incrementPhaseNbre(){
        phaseNbre += 1
        pushNextView()
    }
    func decreasePhaseNbre(){
        phaseNbre -= 1
        pushNextView()
    }
    
    func dismissCreateAnnounce(){
        self.createAnnounceVM = nil
        self.phaseNbre = 0
        self.rootViewController.popToRootViewController(animated: true)
        self.rootViewController.tabBarController?.tabBar.isHidden = false
    }

    
}

