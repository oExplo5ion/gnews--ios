//
//  SortViewModel.swift
//  GNews
//
//  Created by Aleksey on 04.04.2022.
//

import Foundation
import RxSwift
import RxCocoa

class SortViewModel {
    
    // MARK: - Proporties
    let model: BehaviorRelay<ArticleSearchModel>
    
    // MARK: Init
    init(model: ArticleSearchModel){
        self.model = BehaviorRelay<ArticleSearchModel>(value: model)
    }
    
    // MARK: - Funcs
    func toggle(type: ArticleSearchModel.SortBy){
        model.value.toggleSortBy(type: type)
        model.accept(model.value)
    }
    
}
