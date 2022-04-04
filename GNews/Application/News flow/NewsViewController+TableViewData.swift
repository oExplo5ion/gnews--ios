//
//  NewsViewController+TableViewData.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

extension NewsViewController {
    
    enum Cell {
        case title(text: String)
        case article(model: Article)
        case spacer(space: CGFloat)
    }
    
    enum Section {
        case main
    }
    
    class NewsTableViewData: TableViewData {
        typealias Section = NewsViewController.Section
        typealias CellType = NewsViewController.Cell
        var section: NewsViewController.Section = .main
        var cells: [NewsViewController.Cell] = []
    }
    
}
