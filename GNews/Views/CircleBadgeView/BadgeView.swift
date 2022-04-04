//
//  BadgeView.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

class BadgeView: BaseView {
    
    // MARK: - UI
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Font.openSans(size: 10, style: .bold, weight: 700)
        label.text = ""
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - Funcs
    func setup(badge: Int) {
        guard badge >= 1 else {
            badgeLabel.text = ""
            return
        }
        guard badge < 100 else {
            badgeLabel.text = "99+"
            return
        }
        badgeLabel.text = "\(badge)"
    }
    
    // MARK: - Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }
    
    override func setupUI() {
        super.setupUI()
        backgroundColor = Color._FF5B6F
        
        addSubview(badgeLabel)
        badgeLabel.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
}
