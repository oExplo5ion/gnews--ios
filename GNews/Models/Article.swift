//
//  Article.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation
import Unrealm

class Article: Codable, Realmable {
    
    
    // MARK: - Proporties
    var title: String?
    var content: String?
    var url: String?
    var image: String?
    var publishedAt: String?
    
    var source: ArticleSource?
    
    var imageURL: URL? {
        return URL(string: image ?? "")
    }
    
    // MARK: - Init
    required public init() {
        title = nil
        content = nil
        url = nil
        image = nil
        publishedAt = nil
        source = nil
    }
    
    // MARK: - Overrides
    static func primaryKey() -> String? {
        return "url"
    }
    
}
