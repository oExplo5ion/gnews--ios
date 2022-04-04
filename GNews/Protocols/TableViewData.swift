//
//  TableViewData.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation

/**
Abstract presentation of `UITableView`'s data
 */
protocol TableViewData {
    associatedtype Section
    var section: Section { get set }
    associatedtype CellType
    var cells:[CellType] { get set }
}
