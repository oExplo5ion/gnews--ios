//
//  FilterViewModel.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import RxSwift
import RxCocoa

class FilterViewModel {
    
    enum FilterViewModelDefaults {
        static let dateFormatForPresentation = "YYYY/MM/dd"
    }
    
    // MAARK: - Proporties
    private(set) var model: BehaviorRelay<ArticleSearchModel>
    
    var tableData: BehaviorRelay<[FilterViewController.Cell]> {
        var tableData = [FilterViewController.Cell]()
        
        tableData.append(.title(text: Text.filter))
        tableData.append(.spacer(space: 20))
        tableData.append(.subtitle(text: Text.date))
        tableData.append(.spacer(space: 20))
        tableData.append(.dateFrom(text: model.value.fromDate?.string() ?? ""))
        tableData.append(.spacer(space: 26))
        tableData.append(.dateTo(text: model.value.toDate?.string() ?? ""))
        tableData.append(.spacer(space: 33))
        tableData.append(.search)
        
        return BehaviorRelay<[FilterViewController.Cell]>(value: tableData)
    }
    
    // MARK: - Init
    init(model: ArticleSearchModel) {
        self.model = BehaviorRelay<ArticleSearchModel>(value: model)
    }
    
    // MARK: - Funcs
    func reset() {
        self.model.value.from = nil
        self.model.value.to = nil
        self.model.value.searchIn = nil
        model.accept(model.value)
    }
    
    func update(model: ArticleSearchModel) {
        self.model.accept(model)
    }
    
    func setFrom(date: Date) {
        guard let from = date.string() else { return }
        model.value.from = from
        model.accept(model.value)
    }
    
    func setTo(date: Date) {
        guard let to = date.string() else { return }
        model.value.to = to
        model.accept(model.value)
    }
}
