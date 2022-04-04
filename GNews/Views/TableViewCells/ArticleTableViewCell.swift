//
//  ArticleTableViewCell.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let horizontalMargin = CGFloat(16)
    static let articleImageViewHeight = CGFloat(108)
    static let topSpacing: CGFloat = 10
}

class ArticleTableViewCell: BaseTableVieCell, Clickable {
    
    // MARK: - Closures
    var onClick: (() -> Void)?
    
    // MARK: - UI
    private lazy var container: BaseView = {
        let view = BaseView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = Color.lowBlackA.cgColor
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.onClick = {
            self.onClick?()
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color._1E1F21
        label.font = Font.openSans(size: 15, style: .semiBold, weight: 600)
        label.numberOfLines = 2
        label.text = "Isum cillum excepteur"
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color._1E1F21
        label.font = Font.openSans(size: 12, weight: 400)
        label.numberOfLines = 2
        label.text = "Isum cillum excepteur esse aliqua RT5117785 "
        return label
    }()
    
    private lazy var articleImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.tintColor = .gray
        return view
    }()
    
    // MARK: - Public funcs
    func setup(article: Article) {
        if let imageURL = article.imageURL {
            articleImageView.sd_setImage(with: imageURL, completed: nil)
        }
        titleLabel.text = article.title
        subTitleLabel.text = article.content
    }
    
    // MARK: - Overrides
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Defaults.topSpacing)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Defaults.horizontalMargin)
        }
        
        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(snp.centerX).offset(-20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        container.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        container.addSubview(articleImageView)
        articleImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading).offset(-19)
            make.height.equalTo(Defaults.articleImageViewHeight)
        }
    }
    
}
