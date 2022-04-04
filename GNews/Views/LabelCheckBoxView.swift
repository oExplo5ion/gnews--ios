//
//  LabelCheckBoxView.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

fileprivate enum Defaults {
    static let checkBoxSize: CGFloat = 24
}

class LabelCheckBoxView: BaseView, Reactive {
    
    // MARK: - Proporties
    var disposeBag = DisposeBag()
    private(set) var isOn = BehaviorRelay<Bool>(value: false)
    
    // MARK: - UI
    private lazy var overlay: BaseView = {
        let view = BaseView()
        view.onClick = {
            self.isOn.accept(!self.isOn.value)
        }
        return view
    }()
    
    private lazy var checkBox: CheckBoxView = {
        let view = CheckBoxView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.openSans(size: 14, style: .semiBold, weight: 600)
        label.textColor = Color._1E1F21
        return label
    }()
    
    // MARK: - Funcs
    func setup(text: String) {
        titleLabel.text = text
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        subscribeRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    func subscribeRx() {
        isOn
            .observe(on: MainScheduler.instance)
            .subscribe { newValue in
                self.checkBox.isOn = newValue
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        
        addSubview(checkBox)
        checkBox.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.height.equalTo(Defaults.checkBoxSize)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(checkBox)
            make.leading.equalToSuperview()
            make.trailing.equalTo(checkBox.snp.leading).offset(-10)
        }
        
        addSubview(overlay)
        overlay.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
}
