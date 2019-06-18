//
//  Equipments.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 14/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import Foundation

struct Equiqpment: Codable {
    var description: String?
    var category: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case description
        case category
    }
}
