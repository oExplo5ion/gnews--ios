//
//  DatePickerViewModel.swift
//  GNews
//
//  Created by Aleksey on 04.04.2022.
//

import Foundation
import RxSwift
import RxCocoa

class DatePickerViewModel {
    
    // MARK: - Proporties
    private(set) var date = Date()
    
    // MARK: - Init
    init(date: Date) {
        self.date = date
    }
    
    // MARK: - Funcs
    func setDate(date: Date) {
        self.date = date
    }
    
}
