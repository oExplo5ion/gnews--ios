//
//  MainTabBarFactory.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

protocol MainTabBarFactoryProtocol {
    
    func makeHomeCoordinator(rootViewController: UINavigationController) -> SimpleCoordintator
    func makeNewsCoordanitator(rootViewController: UINavigationController) -> SimpleCoordintator
    func makeSearchCoordinator(rootViewController: UINavigationController) -> SearchCoordinator
    func makeProfileCoordinator(rootViewController: UINavigationController) -> SimpleCoordintator
    func makeMoreCoordinator(rootViewController: UINavigationController) -> SimpleCoordintator
    
    func makeWebViewViewController(url: URL) -> WebViewViewController
    
}

class MainTabBarFactory: MainTabBarFactoryProtocol {
    
    func makeHomeCoordinator(rootViewController: UINavigationController) -> SimpleCoordintator {
        let router = BaseRouter(rootViewController: rootViewController)
        return SimpleCoordintator(router: router)
    }
    
    func makeNewsCoordanitator(rootViewController: UINavigationController) -> SimpleCoordintator {
        let router = BaseRouter(rootViewController: rootViewController)
        return SimpleCoordintator(router: router)
    }
    
    func makeSearchCoordinator(rootViewController: UINavigationController) -> SearchCoordinator {
        let router = BaseRouter(rootViewController: rootViewController)
        return SearchCoordinator(router: router)
    }
    
    func makeProfileCoordinator(rootViewController: UINavigationController) -> SimpleCoordintator {
        let router = BaseRouter(rootViewController: rootViewController)
        return SimpleCoordintator(router: router)
    }
    
    func makeMoreCoordinator(rootViewController: UINavigationController) -> SimpleCoordintator {
        let router = BaseRouter(rootViewController: rootViewController)
        return SimpleCoordintator(router: router)
    }
    
    func makeWebViewViewController(url: URL) -> WebViewViewController {
        return WebViewViewController(url: url)
    }

}
