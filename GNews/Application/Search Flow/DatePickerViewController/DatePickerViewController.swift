//
//  DatePickerViewController.swift
//  GNews
//
//  Created by Aleksey on 04.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let transitionAnimationDuration: CGFloat = 0.2
    static let margin: CGFloat = 16
}

class DatePickerViewController: BaseViewController, PopOutAnimatable {
    
    // MARK: - Types
    enum DatePickerViewControllerEvent {
        case onDate(date: Date)
    }
    
    // MARK: - Closures
    var onEvent: ((DatePickerViewControllerEvent) -> Void)?
    
    // MARK: - Proporties
    let viewModel: DatePickerViewModel
    
    // MARK: - UI
    private lazy var overlay: BaseView = {
        let view = BaseView()
        view.onClick = {
            self.onEvent?(.onDate(date: self.viewModel.date))
            self.dismiss(animated: true, completion: nil)
        }
        return view
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.date = viewModel.date
        picker.locale = .current
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.backgroundColor = .white
        picker.layer.shadowOpacity = 1
        picker.layer.shadowRadius = 20
        picker.layer.shadowOffset = CGSize(width: 0, height: 6)
        picker.layer.shadowColor = Color.lowBlackA.cgColor
        picker.layer.cornerRadius = 20
        return picker
    }()
    
    // MARK: - Init
    init(viewModel: DatePickerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    override func subscribeRx() {
        datePicker.rx.date
            .subscribe { date in
                self.viewModel.setDate(date: date)
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        
        view.addSubview(overlay)
        overlay.snp.makeConstraints({ $0.edges.equalToSuperview() })
        
        view.addSubview(datePicker)
    }
    
    func popOutPresent(completion: @escaping () -> Void) {
        datePicker.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalTo(0)
        }

        datePicker.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Defaults.margin)
            make.centerY.equalToSuperview()
        }

        UIView.animate(withDuration: Defaults.transitionAnimationDuration) {
            self.datePicker.layoutIfNeeded()
        } completion: { _ in
            completion()
        }

    }
    
    func popOutDismiss(completion: @escaping () -> Void) {
        completion()
    }
    
}
