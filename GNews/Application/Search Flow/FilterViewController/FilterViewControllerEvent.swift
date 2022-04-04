//
//  FilterViewControllerEvent.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation

extension FilterViewController {
    
    enum FilterViewControllerEvent {
        case onShowSectors
        case onUpadte(model: ArticleSearchModel)
    }
    
}
