//
//  GNewsNetworkManager.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Foundation
import RxSwift
import Moya

class NetworkProvider<T: TargetType> {
    
    // MARK: - Proporties
    let provider = MoyaProvider<T>()
    
    // MARK: - Funcs
    func request<A: Codable>(task: T, model: A.Type) -> Single<A> {
        provider.rx
            .request(task)
            .filterSuccessfulStatusAndRedirectCodes()
            .map(model)
    }
    
}
