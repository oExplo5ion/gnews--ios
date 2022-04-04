//
//  FilterViewTableData.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

extension FilterViewController {
    
    enum Section {
        case main
    }
    
    enum Cell {
        case spacer(space: CGFloat)
        case title(text: String)
        case subtitle(text: String)
        case dateFrom(text: String)
        case dateTo(text: String)
        case search
    }
    
    class FilterViewTableData: TableViewData {
        typealias Section = FilterViewController.Section
        typealias CellType = FilterViewController.Cell
        var section: FilterViewController.Section = .main
        var cells: [FilterViewController.Cell] = []
    }
    
}
