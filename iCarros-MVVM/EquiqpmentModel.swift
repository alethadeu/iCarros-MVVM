//
//  EquiqpmentViewModel.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 14/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import Foundation

struct EquipmentModel {
    private let equipments: [Equiqpment]
    
    public var equipmentsFormated : [String: [String]] {
        var equips: [String: [String]] = [:]
        
        for equip in equipments {
            if let description = equip.description, let category = equip.category {
                if equips.keys.contains(category) {
                    equips[category]?.append(description)
                } else {
                    equips[category] = [description]
                }
            }
        }
        return equips
    }
    
    public var quantity: String {
        return "\(equipments.count) opcionais."
    }
    
    public init(equipments: [Equiqpment]) {
        self.equipments = equipments
    }
}
