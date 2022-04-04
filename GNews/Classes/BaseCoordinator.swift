//
//  BaseCoordinator.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

fileprivate class BaseCoordinatorRouter: Router  {
    
    var rootViewController: UINavigationController?
    
    required init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
}

/**
 Base presentation of `Coordinator` that should be inherited from by any other `Coordinator`
 */
class BaseCoordinator: Coordinator {
    
    /**
     `Coordinator`s stack
     */
    private(set) var childCoordinators: [Coordinator] = []
    
    /**
     Adds child `Coordinator` to a stack
     */
    func addDependency(coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    /**
     Removes child `Coordinator` from a stack
     */
    func removeDependency(coordinator: Coordinator) {
        guard !childCoordinators.isEmpty else { return }
        
        if !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeDependency(coordinator: $0)})
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

}
