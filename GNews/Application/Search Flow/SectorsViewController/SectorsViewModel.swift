//
//  SectorsViewModel.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import RxSwift
import RxCocoa

class SectorsViewModel {
    
    // MARK: - Proporties
    private(set) var model: BehaviorRelay<ArticleSearchModel>
    
//    private(set) var isTitleOn = BehaviorRelay<Bool>(value: false)
//    private(set) var isDescriptionOn = BehaviorRelay<Bool>(value: false)
//    private(set) var isContentOn = BehaviorRelay<Bool>(value: false)
    
    var tableData: BehaviorRelay<[SectorsViewController.Cell]> {
        var tableData = [SectorsViewController.Cell]()
        
        tableData.append(.title(text: Text.searchIn))
        tableData.append(.spacer(space: 6))
        tableData.append(.switchToggle(text: Text.title))
        tableData.append(.switchToggle(text: Text.description))
        tableData.append(.switchToggle(text: Text.content))
        
        return BehaviorRelay<[SectorsViewController.Cell]>(value: tableData)
    }
    
    // MARK: - Init
    init(model: ArticleSearchModel) {
        self.model = BehaviorRelay<ArticleSearchModel>(value: model)
    }
    
    func getCellType(indexPath: IndexPath) -> SectorsViewController.Cell? {
        guard tableData.value.count >= indexPath.row else { return nil }
        return tableData.value[indexPath.row].self
    }
    
    func toggle(type: ArticleSearchModel.SearchIn, isOn: Bool) {
//        defer {
            self.model.value.toggleSearchIn(type: type)
            self.model.accept(model.value)
//        }
//        switch type {
//        case .title:
//            isTitleOn.accept(isOn)
//        case .description:
//            isDescriptionOn.accept(isOn)
//        case .content:
//            isContentOn.accept(isOn)
//        }
    }
    
    func reset() {
//        defer {
            self.model.value.clearSearchIn()
            self.model.accept(model.value)
//        }
//        isTitleOn.accept(false)
//        isDescriptionOn.accept(false)
//        isContentOn.accept(false)
    }
    
}
