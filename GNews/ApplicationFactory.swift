//
//  ApplicationFactory.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation

protocol ApplicationFactoryProtocol {
    func makeMainTabBarCoordinator(router: MainTabBarRouter) -> MainTabBarCoordinator
}

class ApplicationFactory: ApplicationFactoryProtocol {
    func makeMainTabBarCoordinator(router: MainTabBarRouter) -> MainTabBarCoordinator {
        return MainTabBarCoordinator(router: router)
    }
}
