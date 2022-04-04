//
//  SearchViewController+TableView.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return viewModel.tableViewData.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.tableViewData[section].cells.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = viewModel.tableViewData[indexPath.section]
//
//        switch data.cells[indexPath.row] {
//        case .title(let text):
//            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
//            cell.setup(text: text)
//            return cell
//        case .suggestion(let text):
//            let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as! SuggestionTableViewCell
//            let isLastCell = indexPath.row >= data.cells.count
//            cell.setup(text: text, showSeparator: isLastCell)
//            return cell
//        }
//    }
//
//}
