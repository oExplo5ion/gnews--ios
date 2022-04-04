//
//  DateTableViewCell.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let margin: CGFloat = 16
    static let calendarIconSize: CGFloat = 16
    static let separatorHeight: CGFloat = 1
}
//
class DateTableViewCell: BaseTableVieCell, Clickable {
    
    // MARK: - Closures
    var onClick: (() -> Void)?
    
    // MARK: - Proporties
    private(set) var type: DateTableViewCell.DateType = .from
    
    // MARK: - UI
    private lazy var peroidLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color._F68F54
        label.text = Text.from
        label.font = Font.openSans(size: 10, style: .semiBold, weight: 600)
        return label
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Color._F68F54
        imageView.contentMode = .scaleAspectFit
        imageView.image = Image.icCalendar.withRenderingMode(.alwaysTemplate)
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let placeholderAtrs: [NSAttributedString.Key : Any] =
        [
            .foregroundColor : Color._939DAE,
            .font : Font.openSans(size: 14, style: .semiBold, weight: 600)
        ]
        let placeholder = NSAttributedString(string: "yyyy/mm/dd", attributes: placeholderAtrs)
        
        let textField = UITextField()
        textField.attributedPlaceholder = placeholder
        textField.textColor = Color._1E1F21
        textField.isUserInteractionEnabled = false
        
        return textField
    }()
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = Color._F68F54
        return separator
    }()
    
    private lazy var overlay: BaseView = {
        let view = BaseView()
        view.onClick = {
            self.onClick?()
        }
        return view
    }()
    
    // MARK: - Public funcs
    func setup(type: DateTableViewCell.DateType, text: String?) {
        self.type = type
        self.textField.text = text
        self.updateUI()
    }
    
    // MARK: - Private funcs
    private func updateUI() {
        switch type {
        case .from:
            peroidLabel.text = Text.from
        case .to:
            peroidLabel.text = Text.to
        }
    }
    
    // MARK: - Overrides
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(peroidLabel)
        peroidLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Defaults.margin)
        }
        
        contentView.addSubview(calendarImageView)
        calendarImageView.snp.makeConstraints { make in
            make.top.equalTo(peroidLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(Defaults.margin)
            make.width.height.equalTo(Defaults.calendarIconSize)
        }
        
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(peroidLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(Defaults.margin)
            make.trailing.equalTo(calendarImageView.snp.leading).inset(Defaults.margin)
        }
        
        contentView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(textField)
            make.bottom.equalToSuperview()
            make.height.equalTo(Defaults.separatorHeight)
        }
        
        contentView.addSubview(overlay)
        overlay.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
}
