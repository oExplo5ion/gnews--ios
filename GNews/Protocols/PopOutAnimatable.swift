//
//  PopOutAnimatable.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation

protocol PopOutAnimatable {
    func popOutPresent(completion: @escaping () -> Void)
    func popOutDismiss(completion: @escaping () -> Void)
}
