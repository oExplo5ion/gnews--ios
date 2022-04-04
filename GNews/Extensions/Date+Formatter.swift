//
//  Date+Formatter.swift
//  GNews
//
//  Created by Aleksey on 04.04.2022.
//

import Foundation

fileprivate enum Defaults {
    static let defaultDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
}

extension Date {
    static func date(from: String, format: String = Defaults.defaultDateFormat) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: from) ?? Date()
    }
    
    func string(format: String = Defaults.defaultDateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
