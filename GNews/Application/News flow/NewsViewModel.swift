//
//  NewsViewModel.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class NewsViewModel {
    
    // MARK: - Types
    enum Errors: String, Error, LocalizedError {
        case couldNotGetData = "Could not get data"
        var errorDescription: String? { return rawValue }
    }
    
    // MARK: - Proporties
    private(set) lazy var tableViewData = BehaviorRelay<[NewsViewController.Cell]>(value: [])
    private let model = ArticleSearchModel()
    private let provider = ArticlesProvider()
    private let dataBase = RealmRepository.shared
    
    init() {
        tableViewData.accept(getStaticData())
    }
    
    // MARK: - Public funcs
    func fetchExamples() {
        _ = provider.search(model: model)
            .compactMap({ $0.articles })
            .subscribe { articles in
                var data = self.getStaticData()
                for article in articles {
                    data.append(.article(model: article))
                }
                self.tableViewData.accept(data)
            } onError: { error in
                print(error)
            }
    }
    
    // MARK: - Private funcs
    private func getStaticData() -> [NewsViewController.Cell] {
        var cells = [NewsViewController.Cell]()
        cells.append(.title(text: Text.newsTitle))
        cells.append(.spacer(space: 5))
        return cells
    }
    
    private func saveArticles(articles: [Article]) {
        dataBase.insert(objects: articles)
    }
    
}
