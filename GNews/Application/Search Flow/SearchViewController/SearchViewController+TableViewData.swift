//
//  SearchViewController+TableViewData.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

extension SearchViewController {
    
    enum Cell {
        case spacer(space: CGFloat)
        case title(text: String)
        case suggestion(model: Sugesstion)
        case article(model: Article)
    }
    
    enum Section {
        case main
    }
    
    class SearchTableViewData: TableViewData {
        typealias Section = SearchViewController.Section
        typealias CellType = SearchViewController.Cell
        var section = SearchViewController.Section.main
        var cells: [SearchViewController.Cell] = []
    }
    
}
