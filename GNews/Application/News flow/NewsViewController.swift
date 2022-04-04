//
//  NewsViewController.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit
import RxSwift

class NewsViewController: BaseViewController {
    
    // MARK: - Closures
    var onRequestShow: ((Article) -> Void)?
    
    // MARK: - Proporties
    let viewModel = NewsViewModel()
    
    // MARK: - UI
    private lazy var header: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.layer.shadowColor = Color.lowBlackA.cgColor
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.zPosition = 1
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
        view.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        view.register(SpacerTableViewCell.self, forCellReuseIdentifier: SpacerTableViewCell.identifier)
        view.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        return view
    }()
    
    // MARK: - Overrides
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchExamples()
    }
    
    override func subscribeRx() {
        viewModel.tableViewData.bind(to: tableView.rx.items) { (tv, row, item) -> UITableViewCell in
            let indexPath = IndexPath(item: row, section: 0)
            switch item {
            case .spacer(let space):
                let cell = tv.dequeueReusableCell(withIdentifier: SpacerTableViewCell.identifier, for: indexPath) as! SpacerTableViewCell
                cell.setup(space: space)
                return cell
            case .title(let text):
                let cell = tv.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
                cell.setup(text: text)
                return cell
            case .article(let model):
                let cell = tv.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as! ArticleTableViewCell
                cell.setup(article: model)
                cell.onClick = {
                    self.onRequestShow?(model)
                }
                return cell
            }
        }
        .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = Color._F7F7F7
        
        view.addSubview(header)
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaInsets)
            make.leading.trailing.equalToSuperview()
        }
    }
}
