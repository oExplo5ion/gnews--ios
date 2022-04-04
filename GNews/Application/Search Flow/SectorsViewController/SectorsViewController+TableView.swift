//
//  SectorsViewController+TableView.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import UIKit

//extension SectorsViewController: UITableViewDelegate, UITableViewDataSource {
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
//            let cell = tableView.dequeueReusableCell(withIdentifier: SpacerTableViewCell.identifier, for: indexPath) as! SpacerTableViewCell
//            cell.setup(space: space)
//            return cell
//        case .title(let text):
//            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
//            cell.setup(text: text)
//            return cell
//        case .switchToggle(let text, let isOn):
//            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
//            cell.setup(text: text, isOn: isOn)
//            return cell
//        }
//    }
//    
//}
