//
//  Deal.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 14/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import Foundation

struct Deal: Codable {
    var make: String?
    var model: String?
    var trim: String?
    var manufactureYear: Int?
    var modelYear: Int?
    var doors: Int?
    var color: String?
    var gear: String?
    var fuel: String?
    var equipments: [Equiqpment]?
    var photos: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case make
        case model
        case trim
        case manufactureYear
        case modelYear
        case doors
        case color
        case gear
        case fuel
        case equipments
        case photos
    }
    
}
