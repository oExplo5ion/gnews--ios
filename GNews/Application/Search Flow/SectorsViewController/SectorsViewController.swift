//
//  SectorsViewController.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit
import RxSwift

fileprivate enum Defaults {
    static let buttonHeight: CGFloat = 50
    static let margin: CGFloat = 16
    static let bottomMargin: CGFloat = 20
}

class SectorsViewController: BaseViewController {
    
    // MARK: - Closures
    var onEvent: ((SectorsViewControllerEvent) -> Void)?
    
    // MARK: - Proporties
    let viewModel: SectorsViewModel
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
        view.register(SpacerTableViewCell.self, forCellReuseIdentifier: SpacerTableViewCell.identifier)
        view.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        view.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return view
    }()
    
    private lazy var applyButton: GNButton = {
        let titleAtrs: [NSAttributedString.Key : Any] =
        [
            .foregroundColor : UIColor.white,
            .font : Font.openSans(size: 15, style: .bold, weight: 700)
        ]
        let titleText = NSAttributedString(string: Text.apply, attributes: titleAtrs)
        
        let button = GNButton()
        button.setAttributedTitle(titleText, for: .normal)
        button.backgroundColor = Color._F68F54
        button.layer.cornerRadius = Defaults.buttonHeight / 2
        button.onClick = {
            self.onBackAction()
            self.navigationController?.popViewController(animated: true)
        }
        return button
    }()
    
    // MARK: - Init
    init(viewModel: SectorsViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    override func onBackAction() {
        onEvent?(.onUpadte(model: viewModel.model.value))
    }
    
    override func subscribeRx() {
        viewModel.model
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        } onError: { error in
            print(error)
        }.disposed(by: disposeBag)
        
        viewModel.tableData.bind(to: tableView.rx.items){ (tv, row, item) -> UITableViewCell in
            let indexPath = IndexPath(row: row, section: 0)
            
            switch item {
            case .spacer(let space):
                let cell = tv.dequeueReusableCell(withIdentifier: SpacerTableViewCell.identifier, for: indexPath) as! SpacerTableViewCell
                cell.setup(space: space)
                return cell
            case .title(let text):
                let cell = tv.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
                cell.setup(text: text)
                return cell
            case .switchToggle(let text):
                let type = ArticleSearchModel.SearchIn.allCases[indexPath.row - 2]
                let isOn = self.viewModel.model.value.searchIn?.contains(type) ?? false
                let cell = tv.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
                cell.setup(text: text, isOn: isOn)
                cell.onSwitch = { isOn in
                    self.viewModel.toggle(type: type, isOn: isOn)
                }
                return cell
            }
        }.disposed(by: disposeBag)
    }
    
    override func updateNavigationBar() {
        super.updateNavigationBar()
        let button = FilterViewController.NavigationButtonClear()
        button.onClick = {
            self.viewModel.reset()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
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
