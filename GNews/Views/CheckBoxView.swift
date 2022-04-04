//
//  CheckBoxView.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation
import UIKit
import RxSwift

class CheckBoxView: BaseView {
    
    // MARK: - Proporties
    var onTintColor: UIColor = Color._F68F54 {
        didSet {
            updateUI()
        }
    }
    
    var offTintColor: UIColor = Color._F2F2F2 {
        didSet {
            updateUI()
        }
    }
    var isOn: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - UI
    private(set) lazy var circle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Private funcs
    private func updateUI() {
        if isOn {
            circle.isHidden = false
            backgroundColor = onTintColor
            return
        }
        circle.isHidden = true
        backgroundColor = offTintColor
    }
    
    // MARK: - Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin = bounds.size.width * 0.2
        circle.snp.updateConstraints({ $0.edges.equalToSuperview().inset(margin) })
        circle.layer.cornerRadius = circle.bounds.size.height / 2
        
        layer.cornerRadius = bounds.size.height / 2
    }
    
    override func setupUI() {
        defer {
            updateUI()
        }
        super.setupUI()
        
        addSubview(circle)
        circle.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
}
