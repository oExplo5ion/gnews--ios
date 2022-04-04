//
//  NavigationButtonClear.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let trashCanPadding: CGFloat = 12
}

extension FilterViewController {
    
    class NavigationButtonClear: BaseView {
        
        // MARK: - UI
        private lazy var textLabel: UILabel = {
            let label = UILabel()
            label.text = Text.clear
            label.textColor = Color._F68F54
            return label
        }()
        
        private lazy var trashCanImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = Color._F68F54
            imageView.image = Image.icTrashCan.withRenderingMode(.alwaysTemplate)
            return imageView
        }()
        
        // MARK: - Overrides
        override func setupUI() {
            super.setupUI()
            
            addSubview(textLabel)
            textLabel.snp.makeConstraints { make in
                make.leading.top.bottom.equalToSuperview()
            }
            
            addSubview(trashCanImageView)
            trashCanImageView.snp.makeConstraints { make in
                make.top.bottom.trailing.equalToSuperview()
                make.leading.equalTo(textLabel.snp.trailing).offset(Defaults.trashCanPadding)
            }
        }
        
    }
    
}
