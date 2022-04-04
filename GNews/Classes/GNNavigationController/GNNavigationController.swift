//
//  GNNavigationController.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class GNNavigationController: UINavigationController, UISetupable {
    
    // MARK: - Proporties
    private var color: UIColor
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    // MARK: - Init
    init(rootViewController: UIViewController, color: UIColor = .clear) {
        self.color = color
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Overrides
    func setupUI() {
        let appereance = UINavigationBarAppearance()
        appereance.configureWithOpaqueBackground()
        appereance.shadowColor = .clear
        appereance.backgroundColor = color
        
        navigationBar.standardAppearance = appereance
        navigationBar.scrollEdgeAppearance = appereance
    }
    
}
