//
//  Coordinator.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

/**
 Coordinator blueprint
 */
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    func addDependency(coordinator: Coordinator)
    func removeDependency(coordinator: Coordinator)
}
