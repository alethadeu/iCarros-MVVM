//
//  DealViewModel.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 14/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import Foundation

struct DealViewModel {
    weak var dataSource : GenericDataSource<DealModel>?
    
    init(dataSource : GenericDataSource<DealModel>?) {
        self.dataSource = dataSource
    }
    
    func fetchDeals() {
        ServiceClient().getDeals { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(payload: let deals):
                    var dealModels : [DealModel] = []
                    
                    for deal in deals {
                        let dealModel = DealModel(deal: deal)
                        dealModels.append(dealModel)
                    }
                    
                    self.dataSource?.data.value = dealModels
                case .failure(.notFound):
                    print("Not Found")
                    
                case .failure(.unAuthorized):
                    print("unAuthorized")
                    
                case .failure(.none):
                    print("Unknow")
                }
            }
        }
    }
    
}
