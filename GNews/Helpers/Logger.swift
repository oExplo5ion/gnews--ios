//
//  Logger.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation

final class Logger {
    
    static func log(file: String = #fileID, function: String = #function, line: Int = #line) {
        print("log:\nfile: \(file)\nfunction: \(function)\nline: \(line)")
    }
    
}
