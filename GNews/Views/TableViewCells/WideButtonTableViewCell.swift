//
//  WideButtonTableViewCell.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let buttonHeight: CGFloat = 50
    static let margin: CGFloat = 16
}

class WideButtonTableViewCell: BaseTableVieCell {
    
    // MARK: - UI
    private(set) lazy var button: GNButton = {
        let button = GNButton()
        button.backgroundColor = Color._F68F54
        button.layer.cornerRadius = Defaults.buttonHeight / 2
        return button
    }()
    
    // MARK: - Funcs
    func setup(text: String) {
        let titleAtrs: [NSAttributedString.Key : Any] =
        [
            .foregroundColor : UIColor.white,
            .font : Font.openSans(size: 15, style: .bold, weight: 700)
        ]
        let titleText = NSAttributedString(string: text, attributes: titleAtrs)
        
        button.setAttributedTitle(titleText, for: .normal)
    }
    
    // MARK: - Overrides
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Defaults.margin)
            make.height.equalTo(Defaults.buttonHeight)
        }
    }
    
}
