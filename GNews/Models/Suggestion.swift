//
//  Suggestion.swift
//  GNews
//
//  Created by Aleksey on 03.04.2022.
//

import Foundation
import Unrealm

class Sugesstion: Codable, Realmable {
    
    // MARK: - Proporties
    public var text: String?
    
    // MARK: - Init
    required public init() {
        text = nil
    }
    
    // MARK: - Overrides
    public static func primaryKey() -> String? {
        return "text"
    }
}
