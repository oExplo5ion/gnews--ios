//
//  FakeRouter.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class BaseRouter: NSObject, Router {
    
    private(set) weak var rootViewController: UINavigationController?
    
    required init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func present(controller: UIViewController, animated: Bool = true) {
        guard let rootViewController = rootViewController else { return }
        rootViewController.present(controller, animated: true, completion: nil)
    }
    
    func push(controller: UIViewController, animated: Bool = true, isTabBarHidden: Bool = false) {
        guard let rootViewController = rootViewController else { return }
        guard !(controller is UINavigationController) else {
            assertionFailure("Could not push UINavigationController")
            return
        }
        controller.hidesBottomBarWhenPushed = isTabBarHidden
        rootViewController.pushViewController(controller, animated: animated)
    }
    
    func dismissController() {
        rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    public func setRootController(controller: UIViewController, animated: Bool = true) {
        rootViewController?.setViewControllers([controller], animated: animated)
    }
    
}
