//
//  Font.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

enum Font {
    
    enum Style: String {
        case regular = "Regular"
        case bold = "Bold"
        case semiBold = "SemiBold"
    }
    
    static func openSans(size: CGFloat = 12, style: Style = .regular, weight: CGFloat = 100) -> UIFont {
        let fontName = "OpenSans-\(style.rawValue)"
        
        let descriptor = UIFontDescriptor(name: fontName, size: size)
        descriptor.addingAttributes(
            [
                .traits: [UIFontDescriptor.TraitKey.weight: weight]
            ])
        
        return UIFont(descriptor: descriptor, size: size)
    }
    
}
