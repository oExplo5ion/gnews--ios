//
//  ApplicationCoordinator.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class ApplicationCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let factory = ApplicationFactory()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let vc = UINavigationController(rootViewController: MainTabBarViewController())
        vc.isNavigationBarHidden = true
        
        let router = MainTabBarRouter(rootViewController: vc)
        let coordinator = factory.makeMainTabBarCoordinator(router: router)
        coordinator.start()
        
        addDependency(coordinator: coordinator)
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
