//
//  MainTabBarRouter.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class MainTabBarRouter: Router {
    
    private(set) weak var rootViewController: UINavigationController?
    
    required init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func present(_ controller: UIViewController) {
        guard let rootViewController = rootViewController else { return }
        rootViewController.present(controller, animated: true, completion: nil)
    }
    
    func dismissController() {
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}
