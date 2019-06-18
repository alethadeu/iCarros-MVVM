//
//  ServiceClient.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 14/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import Alamofire

class ServiceClient {
    
    //MARK: - Get Deals
    enum getDealsFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetDealsResult = Result<[Deal], getDealsFailureReason>
    typealias GetDealsCompletion =  (_ result: GetDealsResult) -> Void
    
    func getDeals(completion: @escaping GetDealsCompletion) {
        Alamofire.request(Router.getDeals)
            .validate()
            .responseJSON { response in
                switch response.result {
                
                case .success:
                    guard let data = response.data else {
                        completion(.failure(nil))
                        return
                    }
                    
                    do {
                        let deals = try [Deal].decode(data: data)
                        completion(.success(payload:deals))
                    } catch {
                        completion(.failure(nil))
                    }
                   
                case .failure(_):
                    if let statusCode = response.response?.statusCode, let reason = getDealsFailureReason(rawValue: statusCode) {
                        completion(.failure(reason))
                    }
                    completion(.failure(nil))
                    
                }
            }
    }
}
