//
//  SearchViewModel.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation
import RxSwift
import RxCocoa
import Unrealm

class SearchViewModel {
    
    // MARK: - Proporties
    private(set) lazy var articlesTableData = BehaviorRelay<[SearchViewController.Cell]>(value: [])
    private(set) lazy var suggestionsTableData = BehaviorRelay<[SearchViewController.Cell]>(
        value: [
            .title(text: Text.searchHistoryTitle)
        ]
    )
    
    private(set) var model = BehaviorRelay<ArticleSearchModel>(value: ArticleSearchModel())
    private let provider = ArticlesProvider()
    private let dataBase = RealmRepository.shared
    
    init() {
        CFRunLoopPerformBlock(CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue) {
            let suggestions: [Sugesstion] = self.dataBase.getAll()
            let cells = suggestions.map({ SearchViewController.Cell.suggestion(model: $0) }).reversed()
            self.suggestionsTableData.accept([.title(text: Text.searchHistoryTitle)] + cells)
        }
    }
    
    func search(text: String) {
        model.value.q = text
        search()
    }
    
    func update(model: ArticleSearchModel) {
        self.model.accept(model)
    }
    
    func saveSuggestion() {
        guard !model.value.q.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let suggestion = Sugesstion()
        suggestion.text = model.value.q
        
        dataBase.insert(object: suggestion)
        let suggestions: [Sugesstion] = self.dataBase.getAll()
        let cells = suggestions.map({ SearchViewController.Cell.suggestion(model: $0) }).reversed()
        self.suggestionsTableData.accept([.title(text: Text.searchHistoryTitle)] + cells)
    }
    
    func search() {
        _ = provider.search(model: model.value)
            .compactMap({ $0.articles })
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { articles in
                var cells = [SearchViewController.Cell]()
                cells.append(.title(text: "\(articles.count) \(Text.news)"))
                cells.append(.spacer(space: 5))
                for article in articles {
                    cells.append(.article(model: article))
                }
                self.articlesTableData.accept(cells)
                self.save(articles: articles)
            } onError: { error in
                print(error)
            }
    }
    
    // MARK - Private funcs
    private func save(articles: [Article]) {
        dataBase.insert(objects: articles)
    }
    
}
