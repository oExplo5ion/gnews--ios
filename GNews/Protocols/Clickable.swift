//
//  Clickable.swift
//  GNews
//
//  Created by Aleksey on 01.04.2022.
//

import Foundation

protocol Clickable {
    var onClick: (() -> Void)? { get set }
}
