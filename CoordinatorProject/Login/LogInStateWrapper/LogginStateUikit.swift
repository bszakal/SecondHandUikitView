//
//  LogginStateUikit.swift
//  CoordinatorProject
//
//  Created by Benjamin Szakal on 14/12/22.
//

import Combine
import UIKit

protocol LogginStateUikitProtocol {
    var isLoggedIn: Published<Bool>.Publisher {get}
}

class LogginStateUikit: LogginStateUikitProtocol {
    
    
    @Published private var isLoggedInPub = false
    var isLoggedIn: Published<Bool>.Publisher{$isLoggedInPub}
    
    private var cancellable = Set<AnyCancellable>()
    
    @Inject
    var logger: loggerProtocol
    
    init() {
        
        self.isLoggedInPub = logger.getLoginState()
        
        logger.IsSignedInPublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.isLoggedInPub = newValue
            }
            .store(in: &cancellable)
    }
    
}
