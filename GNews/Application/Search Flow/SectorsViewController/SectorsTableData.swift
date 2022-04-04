//
//  SectorsTableData.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

extension SectorsViewController {
    
    enum Section {
        case main
    }
    
    enum Cell {
        case spacer(space: CGFloat)
        case title(text: String)
        case switchToggle(text: String)
    }
    
    class SectorsTableData: TableViewData {
        typealias Section = SectorsViewController.Section
        typealias CellType = SectorsViewController.Cell
        var section: Section = .main
        var cells: [CellType] = []
    }
    
}
