//
//  CirleBadgeView.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

fileprivate enum Defaults {
    static let iconMargin: CGFloat = 15
    static let badgeViewSize: CGFloat = 15
}

class CircleBadgeView: BaseView, Reactive {
    
    // MARK: - Proporties
    var disposeBag = DisposeBag()
    private(set) var badge = BehaviorRelay<Int>(value: 0)
    
    var isOn = BehaviorRelay<Bool>(value: false)
    
    // MARK: - UI
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Color._1E1F21
        imageView.image = Image.icImage.withRenderingMode(.alwaysTemplate)
        return imageView
    }()
    private lazy var badgeView: BadgeView = {
        let badge = BadgeView()
        badge.alpha = 0
        return badge
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        subscribeRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcs
    func setup(icon: UIImage) {
        iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
    }
    
    // MARK: - Private funcs
    private func updateUI() {
        badgeView.setup(badge: badge.value)
        if badge.value >= 1 {
            badgeView.alpha = 1
            return
        }
        badgeView.alpha = 0
        
        if isOn.value {
            backgroundColor = Color._F68F54
            iconImageView.tintColor = .white
            return
        }
        backgroundColor = Color._F7F7F7
        iconImageView.tintColor = Color._1E1F21
    }
    
    // MARK: - Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }
    
    func subscribeRx() {
        isOn
            .observe(on: MainScheduler.instance)
            .subscribe { newValue in
                self.updateUI()
            }.disposed(by: disposeBag)
        badge
            .observe(on: MainScheduler.instance)
            .subscribe { newValue in
                self.updateUI()
            }.disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        backgroundColor = Color._F7F7F7
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Defaults.iconMargin)
        }
        
        addSubview(badgeView)
        badgeView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(-(Defaults.badgeViewSize/6))
            make.width.height.equalTo(Defaults.badgeViewSize)
        }
    }
    
}
