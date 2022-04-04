//
//  ArticleSource.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation
import Unrealm

class ArticleSource: Codable, Realmable {
    
    // MARK: - Proporties
    var name: String?
    var url: String?
    
    // MARK: - Init
    required public init() {
        name = nil
        url = nil
    }
    
}
