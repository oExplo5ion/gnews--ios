//
//  FakeCoordinator.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class SimpleCoordintator: BaseCoordinator {
    
    // MARK: - Closures
    var onRequestShow: ((Article) -> Void)?
    
    // MARK: - Proporties
    let router: BaseRouter
    
    // MARK: - Init
    init(router: BaseRouter) {
        self.router = router
    }
    
    // MARK: - Start
    func start() {
        
    }
}
