//
//  MainTabBarCoordinator+TableView.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

//extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
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
//        case .spacer(let space):
//            let cell = tableView.dequeueReusableCell(withIdentifier: SpacerTableViewCell.identifier, for: indexPath) as! SpacerTableViewCell
//            cell.setup(space: space)
//            return cell
//        case .title(let text):
//            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
//            cell.setup(text: text)
//            return cell
//        case .article(let model):
//            print(model)
//            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as! ArticleTableViewCell
//            return cell
//        }
//    }
//}
