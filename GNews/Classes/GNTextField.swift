//
//  GNTextField.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

fileprivate enum Defaults {
    static let textPadding: CGFloat = 14
}

class GNTextField: UITextField {
    
    var textPadding = UIEdgeInsets(
        top: Defaults.textPadding,
        left: 0,
        bottom: Defaults.textPadding,
        right: 0
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
}
