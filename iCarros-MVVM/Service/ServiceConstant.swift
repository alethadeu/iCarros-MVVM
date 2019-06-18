//
//  ServiceConstant.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 14/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {

   static let baseUrlString = "http://private-525ce1-icarrostest.apiary-mock.com/api"
    
    case getDeals
    
    var method: HTTPMethod {
        switch self {
        case .getDeals:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDeals:
            return "/deals"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseUrlString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getDeals:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
 
        }
        
        return urlRequest
    }
    
}

enum Result<T, U> where U: Error {
    case success(payload: T)
    case failure(U?)
}
