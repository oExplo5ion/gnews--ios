//
//  UITableViewCell+Identifier.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}
