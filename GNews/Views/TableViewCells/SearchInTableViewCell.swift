//
//  SearchInTableViewCell.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let margin: CGFloat = 16
    static let separatorSize: CGFloat = 1
}

class SearchInTableViewCell: BaseTableVieCell, Clickable {
    
    // MARK: - Closures
    var onClick: (() -> Void)?
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Text.searchIn
        label.font = Font.openSans(size: 14, style: .semiBold, weight: 600)
        label.textColor = Color._1E1F21
        return label
    }()
    
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.text = Text.all
        label.font = Font.openSans(size: 14, style: .semiBold, weight: 600)
        label.textColor = Color._939DAE
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = Color._F2F2F2
        return view
    }()
    
    private lazy var overlay: BaseView = {
        let view = BaseView()
        view.onClick = {
            self.onClick?()
        }
        return view
    }()
    
    // MARK: - Funcs
    func setup(model: [ArticleSearchModel.SearchIn]) {
        if model.count == ArticleSearchModel.SearchIn.allCases.count {
            filterLabel.text = Text.all
            return
        }
        filterLabel.text = model.map({ $0.rawValue }).joined(separator: ",")
    }
    
    // MARK: - Overrides
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(Defaults.margin)
        }
        
        contentView.addSubview(filterLabel)
        filterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).inset(10)
            make.trailing.equalToSuperview().inset(Defaults.margin)
        }
        
        contentView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Defaults.margin)
            make.bottom.equalToSuperview()
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(filterLabel)
            make.height.equalTo(Defaults.separatorSize)
        }
        
        contentView.addSubview(overlay)
        overlay.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
}
