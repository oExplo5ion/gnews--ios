//
//  FilteredSearchBarView.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

fileprivate enum Defaults {
    static let margin: CGFloat = 15
    static let textFieldMaxWidth: CGFloat = 442
    static let textFieldHeight: CGFloat = 46
    static let textFieldLeftViewInset: CGFloat = 9
    static let textFieldCornerRadius: CGFloat = 100
    static let buttonSize: CGFloat = 46
}

class FilteredSearchBarView: BaseView, Reactive {
    
    // MARK: - Proporties
    var disposeBag = DisposeBag()
    var event = BehaviorRelay<FilteredSearchBarViewEvent>(value: .none)
    var isSortOn = BehaviorRelay<Bool>(value: false)
    
    private(set) var text = BehaviorRelay<String>(value: "")
    
    // MARK: - UI
    private(set) lazy var textField: GNTextField = {
        let leftView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            
            let imageView = UIImageView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: 20,
                    height: 20
                )
            )
            imageView.contentMode = .scaleAspectFit
            imageView.image = Image.icSearch.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = Color._939DAE
            
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.leading.equalToSuperview().inset(Defaults.margin)
                make.trailing.equalToSuperview().inset(Defaults.textFieldLeftViewInset)
            }
            
            return view
        }()
        
        let rightView: UIView = {
            let view = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: Defaults.margin,
                    height: 0
                )
            )
            return view
        }()
        
        let placeholderAtrs: [NSAttributedString.Key : Any] =
        [
            .font : Font.openSans(size: 14, style: .semiBold, weight: 600),
            .foregroundColor : Color._939DAE
        ]
        let placeHolder = NSAttributedString(string: Text.searchPlaceHolder, attributes: placeholderAtrs)
        
        let textField = GNTextField()
        textField.attributedPlaceholder = placeHolder
        textField.textColor = Color._1E1F21
        textField.backgroundColor = Color._F7F7F7
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.leftView = leftView
        textField.rightView = rightView
        textField.layer.cornerRadius = Defaults.textFieldHeight / 2
        return textField
    }()
    
    private lazy var filterButton: CircleBadgeView = {
        let button = CircleBadgeView()
        button.setup(icon: Image.icFilter)
        button.badge.accept(3)
        button.snp.makeConstraints { make in
            make.width.height.equalTo(Defaults.buttonSize)
        }
        button.onClick = {
            self.event.accept(.onFilter)
        }
        return button
    }()
    
    private lazy var sortButton: CircleBadgeView = {
        let button = CircleBadgeView()
        button.setup(icon: Image.icSort)
        button.snp.makeConstraints { make in
            make.width.height.equalTo(Defaults.buttonSize)
        }
        button.onClick = {
            self.event.accept(.onSort)
        }
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleAspectFit
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        stack.addArrangedSubview(filterButton)
        stack.addArrangedSubview(sortButton)
        
        return stack
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        subscribeRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    func subscribeRx() {
        textField.rx
            .text
            .compactMap({ $0 })
            .subscribe { text in
                self.text.accept(text)
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
        
        isSortOn
            .subscribe { value in
                self.sortButton.isOn.accept(value)
            } onError: { _ in
                
            }.disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        backgroundColor = .white
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(Defaults.margin)
            make.height.equalTo(46)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(Defaults.margin)
            make.trailing.equalTo(stack.snp.leading).offset(-16)
            make.width.lessThanOrEqualTo(Defaults.textFieldMaxWidth)
            make.height.equalTo(Defaults.textFieldHeight)
        }
    }
    
}
