//
//  SortViewController.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation
import UIKit
import RxSwift

fileprivate enum Defaults {
    static let margin: CGFloat = 16
    static let separatorHeight: CGFloat = 1
    static let separatorTopMargin: CGFloat = 20
    static let transitionPressentDuration: CGFloat = 0.5
    static let scrollViewAdditionalSize: CGFloat = 20
    static let transitionDismissDuration: CGFloat = 0.2
}

class SortViewController: BaseViewController, PopOutAnimatable {
    
    // MARK: - Closures
    var onEvent: ((SortViewControllerEvent) -> Void)?
    
    // MARK: - Proporties
    let viewModel: SortViewModel
    
    private lazy var ui: [UIView] = {
        [
            addBox(view: titleLabel),
            addBox(view: checkBoxUploadDate),
            addBox(view: checkBoxRelevance)
        ]
    }()
    
    // MARK: - UI
    private lazy var overlay: BaseView = {
        let view = BaseView()
        view.onClick = {
            self.dismiss(animated: true, completion: {
                self.onBackAction()
            })
        }
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.layer.shadowOpacity = 1
        scrollView.layer.shadowRadius = 20
        scrollView.layer.shadowOffset = CGSize(width: 0, height: -10)
        scrollView.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        scrollView.layer.cornerRadius = 20
        scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Text.sortBy
        label.font = Font.openSans(size: 16, style: .bold, weight: 700)
        return label
    }()
    
    private lazy var checkBoxUploadDate: LabelCheckBoxView = {
        let view = LabelCheckBoxView()
        view.setup(text: Text.uploadDate)
        view.isOn.accept(viewModel.model.value.sortBy?.contains(.publishedAt) ?? false)
        return view
    }()
    
    private lazy var checkBoxRelevance: LabelCheckBoxView = {
        let view = LabelCheckBoxView()
        view.setup(text: Text.relevance)
        view.isOn.accept(viewModel.model.value.sortBy?.contains(.relevance) ?? false)
        return view
    }()
    
    // MARK: - Init
    init(viewModel: SortViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private funcs
    private func addBox(view: UIView) -> UIView {
        let box = UIView()
        
        box.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        let separator = UIView()
        separator.backgroundColor = Color._F2F2F2
        
        box.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(Defaults.separatorTopMargin)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Defaults.separatorHeight)
        }
        
        return box
    }
    
    // MARK: - Overrides
    func popOutPresent(completion: @escaping () -> Void) {
        var contentSize = self.container.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let safeAreaSize = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        contentSize += safeAreaSize
        contentSize += Defaults.scrollViewAdditionalSize
        
        UIView.animate(
            withDuration: Defaults.transitionPressentDuration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: .curveEaseOut) {
                self.scrollView.frame = CGRect(
                    x: 0,
                    y: (self.view.bounds.size.height - contentSize) + 20,
                    width: self.view.bounds.size.width,
                    height: contentSize
                )
            } completion: { _ in
                completion()
        }
    }
    
    func popOutDismiss(completion: @escaping () -> Void) {
        var contentSize = self.container.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let safeAreaSize = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        contentSize += safeAreaSize
        contentSize += Defaults.scrollViewAdditionalSize
        
        UIView.animate(withDuration: Defaults.transitionDismissDuration) {
            self.scrollView.frame = CGRect(
                x: 0,
                y: self.view.bounds.size.height,
                width: self.view.bounds.size.width,
                height: contentSize
            )
        } completion: { _ in
            completion()
        }
    }
    
    override func onBackAction() {
        onEvent?(.onUpdate(model: viewModel.model.value))
    }
    
    override func subscribeRx() {
        checkBoxUploadDate.isOn
            .observe(on: MainScheduler.instance)
            .skip(1)
            .distinctUntilChanged()
            .subscribe { value in
                self.viewModel.toggle(type: .publishedAt)
            } onError: { _ in

            }.disposed(by: disposeBag)

        checkBoxRelevance.isOn
            .observe(on: MainScheduler.instance)
            .skip(1)
            .distinctUntilChanged()
            .subscribe { value in
                self.viewModel.toggle(type: .relevance)
            } onError: { _ in

            }.disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .clear
        
        view.addSubview(overlay)
        overlay.snp.makeConstraints({ $0.edges.equalToSuperview() })
        
        view.addSubview(scrollView)
        scrollView.frame = CGRect(
            x: 0,
            y: view.bounds.size.height,
            width: view.bounds.size.width,
            height: view.bounds.size.height
        )
        
        scrollView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        for (index, element) in ui.enumerated() {
            
            if ui.count == 1 {
                container.addSubview(element)
                element.snp.makeConstraints({ $0.edges.equalToSuperview().inset(Defaults.margin) })
                break
            }
            
            // place first element
            if index <= 0 {
                container.addSubview(element)
                element.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(Defaults.margin).priority(.high)
                    make.leading.trailing.equalToSuperview().inset(Defaults.margin)
                }
                continue
            }
            
            let prevElement = ui[index - 1]
            
            // place last element
            if index == (ui.count - 1) {
                container.addSubview(element)
                element.snp.makeConstraints { make in
                    make.top.equalTo(prevElement.snp.bottom).offset(Defaults.margin).priority(.medium)
                    make.leading.trailing.equalToSuperview().inset(Defaults.margin)
                    make.bottom.equalToSuperview().priority(.low)
                }
                continue
            }
            
            // place element in the middle
            container.addSubview(element)
            element.snp.makeConstraints { make in
                make.top.equalTo(prevElement.snp.bottom).offset(Defaults.margin)
                make.leading.trailing.equalToSuperview().inset(Defaults.margin)
            }
            
        }
    }
    
}
