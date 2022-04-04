//
//  BaseView.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class BaseView: UIView, UISetupable, Clickable {
    
    var onClick: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {}
    
}

extension BaseView {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onClick?()
    }
}
