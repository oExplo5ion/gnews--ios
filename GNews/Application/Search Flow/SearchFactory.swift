//
//  SearchFactory.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation

protocol SearchFactoryProtocol {
    func makeSearchViewController() -> SearchViewController
    func makeFilterViewController(model: ArticleSearchModel) -> FilterViewController
    func makeSectorsViewController(model: ArticleSearchModel) -> SectorsViewController
    func makeSortViewController(model: ArticleSearchModel) -> SortViewController
}

class SearchFactory: SearchFactoryProtocol {
    
    func makeSearchViewController() -> SearchViewController {
        return SearchViewController()
    }
    
    func makeFilterViewController(model: ArticleSearchModel) -> FilterViewController {
        let viewModel = FilterViewModel(model: model)
        return FilterViewController(viewModel: viewModel)
    }
    
    func makeSectorsViewController(model: ArticleSearchModel) -> SectorsViewController {
        let viewModel = SectorsViewModel(model: model)
        return SectorsViewController(viewModel: viewModel)
    }
    
    func makeSortViewController(model: ArticleSearchModel) -> SortViewController {
        let viewModel = SortViewModel(model: model)
        return SortViewController(viewModel: viewModel)
    }
    
}
