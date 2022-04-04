//
//  MainTabBarViewController.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController, UISetupable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = Color._F78F54
        tabBar.unselectedItemTintColor = Color._939DAE
        tabBar.layer.shadowColor = Color.lowBlackB.cgColor
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowRadius = 20
        tabBar.layer.shadowOffset = .zero
    }
}
