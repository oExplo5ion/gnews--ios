//
//  GNNavigationBackButtonItem.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

extension GNNavigationController {
    
    class GNNavigationBackButtonItem: BaseView {
        
        // MARK: - UI
        private lazy var backButtonImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = Color._F68F54
            imageView.image = Image.icBackButton.withRenderingMode(.alwaysTemplate)
            return imageView
        }()
        
        // MARK: - Overrides
        override func setupUI() {
            super.setupUI()
            backgroundColor = .clear
            
            addSubview(backButtonImageView)
            backButtonImageView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        }
        
    }
    
}
