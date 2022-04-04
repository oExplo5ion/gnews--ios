//
//  ArticleSearchModel.swift
//  GNews
//
//  Created by Aleksey on 03.04.2022.
//

import Foundation

fileprivate enum Defaults {
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
}

class ArticleSearchModel {
    
    // MARK: - Types
    enum SearchIn: String, CaseIterable {
        case title = "title"
        case description = "description"
        case content = "content"
    }
    
    enum SortBy: String {
        case publishedAt = "publishedAt"
        case relevance = "relevance"
    }
    
    // MARK: - Proporties
    private let token = Host.apiToken
    
    var q: String = "example"
    var max: Int = 50
    var from: String?
    var to: String?
    var searchIn: Set<SearchIn>?
    var sortBy: Set<SortBy>?
    
    var fromDate: Date? {
        guard let from = from else { return nil }
        return Date.date(from: from)
    }
    
    var toDate: Date? {
        guard let from = to else { return nil }
        return Date.date(from: from)
    }
    
    // MARK: - Funcs
    func toggleSearchIn(type: SearchIn) {
        if searchIn == nil {
            searchIn = []
        }
        if let index = searchIn?.firstIndex(of: type) {
            searchIn?.remove(at: index)
            return
        }
        searchIn?.insert(type)
    }
    
    func clearSearchIn() {
        searchIn?.removeAll()
    }
    
    func toggleSortBy(type: SortBy) {
        if sortBy == nil {
            sortBy = []
        }
        if let index = sortBy?.firstIndex(of: type) {
            sortBy?.remove(at: index)
            return
        }
        sortBy?.insert(type)
    }
    
    // MARK: - Funcs
    func toDict() -> [String : Any] {
        var params = [String : Any]()
        
        if q.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            q = "example"
        }
        params["q"] = q
        
        if max <= -1 {
            max = 10
        }
        if max >= 101 {
            max = 100
        }
        params["max"] = max
        
        if let from = from {
            params["from"] = from
        }
        
        if let to = to {
            params["tp"] = to
        }
        
        if let searchIn = searchIn {
            params["in"] = searchIn.map({ $0.rawValue }).joined(separator: ",")
        }
        
        if let sortBy = sortBy {
            params["sortby"] = sortBy.map({ $0.rawValue }).joined(separator: ",")
        }
        
        params["token"] = token
        
        return params
    }
    
}
