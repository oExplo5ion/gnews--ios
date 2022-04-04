//
//  SpacerTableViewCell.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class SpacerTableViewCell: BaseTableVieCell {
    
    // MARK: - UI
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Public funcs
    func setup(space: CGFloat) {
        container.snp.updateConstraints { make in
            make.top.bottom.equalToSuperview().inset(space)
        }
        layoutIfNeeded()
    }
    
    // MARK: - Overrides
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}
