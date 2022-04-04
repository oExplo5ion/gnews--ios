//
//  GNewsService.swift
//  GNews
//
//  Created by Aleksey on 02.04.2022.
//

import Moya

enum ArticlesAPI {
    case examples(parameters: [String: Any])
}

extension ArticlesAPI: TargetType {
    
    var baseURL: URL {
        return Host.endpoint
    }
    
    var path: String {
        switch self {
        case .examples:
            return "/search"
        }
    }
    
    var task: Task {
        switch self {
        case .examples(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var method: Method {
        switch self {
        case .examples:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
