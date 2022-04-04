//
//  Reactive.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation
import RxSwift

protocol Reactive {
    var disposeBag: DisposeBag { get set }
    func subscribeRx()
}
