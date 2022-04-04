//
//  FilterViewController.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let buttonHeight: CGFloat = 50
    static let margin: CGFloat = 16
    static let bottomMargin: CGFloat = 20
}


class FilterViewController: BaseViewController, ArticleSearchModelViewController {
    
    // MARK: - Closures
    var onEvent: ((FilterViewController.FilterViewControllerEvent) -> Void)?
    
    // MARK: - Proporties
    let viewModel: FilterViewModel
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
        view.register(SpacerTableViewCell.self, forCellReuseIdentifier: SpacerTableViewCell.identifier)
        view.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        view.register(SpacerTableViewCell.self, forCellReuseIdentifier: SpacerTableViewCell.identifier)
        view.register(DateTableViewCell.self, forCellReuseIdentifier: DateTableViewCell.identifier)
        view.register(SearchInTableViewCell.self, forCellReuseIdentifier: SearchInTableViewCell.identifier)
        return view
    }()
    
    private lazy var applyButton: GNButton = {
        let titleAtrs: [NSAttributedString.Key : Any] =
        [
            .foregroundColor : UIColor.white,
            .font : Font.openSans(size: 15, style: .bold, weight: 700)
        ]
        let titleText = NSAttributedString(string: Text.applyFilter, attributes: titleAtrs)
        
        let button = GNButton()
        button.setAttributedTitle(titleText, for: .normal)
        button.backgroundColor = Color._F68F54
        button.layer.cornerRadius = Defaults.buttonHeight / 2
        button.onClick = {
            self.navigationController?.popViewController(animated: true)
            self.onBackAction()
        }
        return button
    }()
    
    // MARK: - Overrides
    init(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func onBackAction() {
        self.onEvent?(.onUpadte(model: viewModel.model.value))
    }
    
    override func updateNavigationBar() {
        super.updateNavigationBar()
        let button = FilterViewController.NavigationButtonClear()
        button.onClick = {
            self.viewModel.reset()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func updateModel(model: ArticleSearchModel) {
        self.viewModel.update(model: model)
    }
    
    override func subscribeRx() {
        viewModel.model.subscribe { _ in
            self.tableView.reloadData()
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
        
        viewModel.tableData.bind(to: tableView.rx.items){ (tv, row, item) -> UITableViewCell in
            let indexPath = IndexPath(item: row, section: 0)
            
            switch item {
            case .spacer(let space):
                let cell = tv.dequeueReusableCell(withIdentifier: SpacerTableViewCell.identifier, for: indexPath) as!
                SpacerTableViewCell
                cell.setup(space: space)
                return cell
            case .title(let text):
                let cell = tv.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
                cell.setup(text: text)
                return cell
            case .subtitle(let text):
                let cell = tv.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
                cell.setup(text: text, font: Font.openSans(size: 14, style: .semiBold, weight: 600))
                return cell
            case .dateFrom:
                let cell = tv.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
                cell.setup(
                    type: .from,
                    text: self.viewModel.model.value.fromDate?.string(format: FilterViewModel.FilterViewModelDefaults.dateFormatForPresentation)
                )
                cell.onClick = {
                    let viewModel = DatePickerViewModel(date: self.viewModel.model.value.fromDate ?? Date())
                    let vc = DatePickerViewController(viewModel: viewModel)
                    vc.onEvent = { event in
                        switch event {
                        case .onDate(let date):
                            self.viewModel.setFrom(date: date)
                        }
                    }
                    self.present(vc, animated: true, completion: nil)
                }
                return cell
            case .dateTo:
                let cell = tv.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
                cell.setup(
                    type: .to,
                    text: self.viewModel.model.value.toDate?.string(format: FilterViewModel.FilterViewModelDefaults.dateFormatForPresentation)
                )
                cell.onClick = {
                    let viewModel = DatePickerViewModel(date: self.viewModel.model.value.fromDate ?? Date())
                    let vc = DatePickerViewController(viewModel: viewModel)
                    vc.onEvent = { event in
                        switch event {
                        case .onDate(let date):
                            self.viewModel.setTo(date: date)
                        }
                    }
                    self.present(vc, animated: true, completion: nil)
                }
                return cell
            case .search:
                let cell = tv.dequeueReusableCell(withIdentifier: SearchInTableViewCell.identifier, for: indexPath) as!
                SearchInTableViewCell
                cell.setup(model: Array(self.viewModel.model.value.searchIn ?? []))
                cell.onClick = {
                    self.onEvent?(.onShowSectors)
                }
                return cell
            }
        }.disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaInsets)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Defaults.margin)
            make.leading.trailing.equalToSuperview().inset(Defaults.margin)
            make.height.equalTo(Defaults.buttonHeight)
        }
    }
    
}
