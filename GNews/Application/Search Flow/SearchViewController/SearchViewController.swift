//
//  SearchViewController.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController, ArticleSearchModelViewController {
    
    // MARK: - Types
    enum SearchViewControllerEvent {
        case onShowFilter(model: ArticleSearchModel)
        case onShowSort
    }
    
    enum SearchViewControllerState {
        case normal
        case searching
    }
    
    // MARK: - Closures
    var onRequestShow: ((Article) -> Void)?
    
    // MARK: - Proporties
    let viewModel = SearchViewModel()
    private var state = BehaviorRelay<SearchViewControllerState>(value: .normal)
    private var isArticlesTableViewHiden = BehaviorRelay<Bool>(value: false)
    private var isSearchTableViewHiden = BehaviorRelay<Bool>(value: true)
    private lazy var isSortOn = BehaviorRelay<Bool>(value: viewModel.model.value.sortBy != nil)
    
    // MARK: - Closures
    var onEvent: ((SearchViewControllerEvent) -> Void)?
    
    // MARK: - UI
    private lazy var header: FilteredSearchBarView = {
        let view = FilteredSearchBarView()
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.layer.shadowColor = Color.lowBlackA.cgColor
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.zPosition = 1
        return view
    }()
    
    private lazy var searchTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = Color._F7F7F7
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
        view.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        view.register(SuggestionTableViewCell.self, forCellReuseIdentifier: SuggestionTableViewCell.identifier)
        return view
    }()
    
    private lazy var articlesTableView: UITableView = {
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
        viewModel.search()
    }
    
    func updateModel(model: ArticleSearchModel) {
        self.viewModel.update(model: model)
    }
    
    override func subscribeRx() {
        state
            .observe(on: MainScheduler.instance)
            .subscribe { state in
                switch state {
                case .normal:
                    self.isArticlesTableViewHiden.accept(false)
                    self.isSearchTableViewHiden.accept(true)
                case .searching:
                    self.isArticlesTableViewHiden.accept(true)
                    self.isSearchTableViewHiden.accept(false)
                }
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        viewModel.model
            .subscribe { model in
                let isOn = (model.sortBy?.count ?? 0) >= 1
                self.header.isSortOn.accept(isOn)
            } onError: { _ in
                
            }.disposed(by: disposeBag)
        
        // header
        header.text
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { text in
                self.viewModel.search(text: text)
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
        
        header.event
            .subscribe { event in
                switch event {
                case .none:
                    break
                case .onFilter:
                    self.onEvent?(.onShowFilter(model: self.viewModel.model.value))
                case .onSort:
                    self.onEvent?(.onShowSort)
                }
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
        
        header.textField.rx
            .controlEvent([.editingDidEnd])
            .subscribe { _ in
                self.state.accept(.normal)
                self.viewModel.saveSuggestion()
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
        
        header.textField.rx
            .controlEvent([.editingDidBegin])
            .subscribe { _ in
                self.state.accept(.searching)
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
        
        // table view
        isArticlesTableViewHiden.bind(to: articlesTableView.rx.isHidden).disposed(by: disposeBag)
        isSearchTableViewHiden.bind(to: searchTableView.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.articlesTableData.bind(to: articlesTableView.rx.items) { (tv, row, item) -> UITableViewCell in
            let indexPath = IndexPath(item: row, section: 0)
            switch item {
            case .title(let text):
                let cell = tv.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
                cell.setup(text: text)
                return cell
            case .suggestion:
                return UITableViewCell()
            case .spacer(let space):
                let cell = tv.dequeueReusableCell(withIdentifier: SpacerTableViewCell.identifier, for: indexPath) as! SpacerTableViewCell
                cell.setup(space: space)
                return cell
            case .article(let model):
                let cell = tv.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as! ArticleTableViewCell
                cell.setup(article: model)
                cell.onClick = {
                    self.onRequestShow?(model)
                }
                return cell
            }
        }.disposed(by: disposeBag)
        
        viewModel.suggestionsTableData.bind(to: searchTableView.rx.items) { (tv, row, item) -> UITableViewCell in
            let indexPath = IndexPath(item: row, section: 0)
            switch item {
            case .title(let text):
                let cell = tv.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
                cell.setup(text: text)
                return cell
            case .suggestion(let model):
                let cell = tv.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as! SuggestionTableViewCell
                let isLastCell = row < (self.viewModel.suggestionsTableData.value.count - 1)
                cell.setup(text: model.text ?? "", showSeparator: isLastCell)
                return cell
            case .spacer(let space):
                let cell = tv.dequeueReusableCell(withIdentifier: SpacerTableViewCell.identifier, for: indexPath) as! SpacerTableViewCell
                cell.setup(space: space)
                return cell
            case .article(_):
                return UITableViewCell()
            }
        }.disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .white
        
        view.addSubview(header)
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(articlesTableView)
        articlesTableView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalTo(view.safeAreaInsets)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(searchTableView)
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.bottom.equalTo(view.safeAreaInsets)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}
