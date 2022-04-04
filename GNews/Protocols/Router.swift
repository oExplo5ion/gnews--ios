//
//  Router.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

/**
 Holds an reference to top level `UINavigationController` in current flow. Responsible for presentation/dismiss actions
 */
protocol Router: AnyObject {
    var rootViewController: UINavigationController? { get }
    init(rootViewController: UINavigationController)
}
