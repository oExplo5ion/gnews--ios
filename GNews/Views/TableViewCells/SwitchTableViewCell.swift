//
//  SwitchTableViewCell.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let margin: CGFloat = 16
    static let switchSize: CGSize = CGSize(width: 45, height: 24)
    static let separatorHeight: CGFloat = 1
    static let separatorTopMargin: CGFloat = 15
}

class SwitchTableViewCell: BaseTableVieCell {
    
    // MARK: - Closures
    var onSwitch: ((Bool) -> Void)?
    
    // MARK: - UI
    private lazy var switchView: UISwitch = {
        let view = UISwitch()
        view.onTintColor = Color._F68F54
        view.tintColor = Color._939DAE
        view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        view.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.openSans(size: 14, style: .semiBold, weight: 600)
        label.textColor = Color._1E1F21
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = Color._F2F2F2
        return view
    }()
    
    // MARK: - Funcs
    func setup(text: String, isOn: Bool) {
        titleLabel.text = text
        switchView.isOn = isOn
    }
    
    // MARK: - Private funcs
    @objc private func switchToggled(_ switchView: UISwitch) {
        self.onSwitch?(switchView.isOn)
    }
    
    // MARK: - Overrides
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Defaults.margin/2)
            make.trailing.equalToSuperview().inset(Defaults.margin)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Defaults.margin)
            make.leading.equalToSuperview().offset(Defaults.margin)
            make.trailing.equalTo(switchView.snp.leading).offset(-10)
        }
        
        contentView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Defaults.separatorTopMargin)
            make.bottom.equalToSuperview()
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(switchView)
            make.height.equalTo(Defaults.separatorHeight)
        }
    }
    
}
