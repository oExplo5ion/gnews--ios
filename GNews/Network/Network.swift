//
//  Network.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation

enum Host {
    
    static var apiToken: String {
        fatalError("add token here")
    }
    static let endpoint = URL(string: "https://gnews.io/api/v4")!
    
}
