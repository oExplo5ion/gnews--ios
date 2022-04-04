//
//  NavigationItemLogoView.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class NavigationItemLogoView: BaseView {
    
    // MARK: - UI
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = Image.logo
        return view
    }()
    
    // MARK: - Overrides
    override func setupUI() {
        backgroundColor = .clear
        
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}
