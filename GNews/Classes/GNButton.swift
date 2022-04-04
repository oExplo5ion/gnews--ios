//
//  GNButton.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

class GNButton: UIButton, Clickable {
    
    var onClick: (() -> Void)?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onClick?()
    }
    
}
