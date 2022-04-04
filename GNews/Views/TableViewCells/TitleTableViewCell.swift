//
//  TitleTableViewCell.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let horizontalMargin = CGFloat(16)
}

class TitleTableViewCell: BaseTableVieCell {
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color._1E1F21
        label.font = Font.openSans(size: 16, style: .bold, weight: 700)
        return label
    }()
    
    // MARK: - Public funcs
    func setup(text: String) {
        setup(text: text, font: Font.openSans(size: 16, style: .bold, weight: 700))
    }
    
    func setup(text: String, font: UIFont) {
        titleLabel.text = text
        titleLabel.font = font
    }
    
    // MARK: - Overrides
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Defaults.horizontalMargin)
        }
    }
    
}
