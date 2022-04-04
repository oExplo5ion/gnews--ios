//
//  SuggestionTableViewCell.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let margin: CGFloat = 16
    static let separatorHeight: CGFloat = 1
}

class SuggestionTableViewCell: BaseTableVieCell {
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color._1E1F21
        label.font = Font.openSans(size: 14, style: .semiBold, weight: 600)
        return label
    }()
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
    }()
    
    // MARK: - Funcs
    func setup(text: String, showSeparator: Bool = true) {
        titleLabel.text = text
        separator.alpha = showSeparator ? 1 : 0
    }
    
    // MARK: - Overrides
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(Defaults.margin)
        }
        
        contentView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Defaults.margin)
            make.leading.trailing.equalToSuperview().inset(Defaults.margin)
            make.bottom.equalToSuperview()
            make.height.equalTo(Defaults.separatorHeight)
        }
    }
    
}
