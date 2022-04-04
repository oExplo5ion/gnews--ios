//
//  ArticlesProvider.swift
//  GNews
//
//  Created by Aleksey on 03.04.2022.
//

import Foundation
import RxSwift

class ArticlesProvider: NetworkProvider<ArticlesAPI> {
    
    // MARK: - Types
    struct ArticlesResultA: Codable {
        var totalArticles: Int?
        var articles: [Article]?
    }
    
    func search(model: ArticleSearchModel) -> Observable<ArticlesResultA> {
        return request(task: .examples(parameters: model.toDict()), model: ArticlesResultA.self).asObservable()
    }
    
}
