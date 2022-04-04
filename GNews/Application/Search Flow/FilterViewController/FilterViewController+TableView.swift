//
//  FilterViewController+TableView.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

//extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return viewModel.tableData.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.tableData[section].cells.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = viewModel.tableData[indexPath.section]
//
//        switch data.cells[indexPath.row] {
//        case .spacer(let space):
//            let cell = tableView.dequeueReusableCell(withIdentifier: SpacerTableViewCell.identifier, for: indexPath) as!
//            SpacerTableViewCell
//            cell.setup(space: space)
//            return cell
//        case .title(let text):
//            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
//            cell.setup(text: text)
//            return cell
//        case .subtitle(let text):
//            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
//            cell.setup(text: text, font: Font.openSans(size: 14, style: .semiBold, weight: 600))
//            return cell
//        case .dateFrom:
//            let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
//            cell.setup(type: .from)
//            cell.onClick = {
//
//            }
//            return cell
//        case .dateTo:
//            let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
//            cell.setup(type: .to)
//            cell.onClick = {
//                let viewModel = DatePickerViewModel(date: self.viewModel.model.va.fromDate)
//                let vc = DatePickerViewController(viewModel: viewModel)
//                vc.onEvent = { event in
//                    switch event {
//                    case .onDate(let date):
//                        self.viewModel.setFrom(date: date)
//                    }
//                }
//                self.present(vc, animated: true, completion: nil)
//            }
//            return cell
//        case .search:
//            let cell = tableView.dequeueReusableCell(withIdentifier: SearchInTableViewCell.identifier, for: indexPath) as!
//            SearchInTableViewCell
//            cell.onClick = {
//                self.onEvent?(.onShowSectors)
//            }
//            return cell
//        }
//    }
//
//}
