//
//  DealViewModel.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 14/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import Foundation
import ImageSlideshow

struct DealModel {
    private let deal: Deal
    
    public var make: String {
        guard let make = deal.make else { return "N/D" }
        return make
    }
    
    public var model: String {
        guard let model = deal.model else { return "N/D" }
        return model
    }
    
    public var trim: String {
        guard let trim = deal.trim else { return "N/D" }
        return trim
    }
    
    public var year: String {
        guard let manYear = deal.manufactureYear,
              let modYear = deal.modelYear
        else { return "N/D" }
        
        return "\(manYear) - \(modYear)"
    }
    
    public var gear: String {
        guard let gear = deal.gear else { return "N/D" }
        return gear
    }
    
    public var doors: String {
        guard let doors = deal.doors else { return "N/D" }
        return "\(doors)"
    }
    
    public var fuel: String {
        guard let fuel = deal.fuel else { return "N/D" }
        return "\(fuel)"
    }
    
    public var color: String {
        guard let color = deal.color else { return "N/D" }
        return color
    }
    
    public var photos: [InputSource] {
        guard let photosURL = deal.photos else { return [] }
        var imageInputs: [InputSource] = []
        
        for url in photosURL {
            if let input = AlamofireSource(urlString: url, placeholder: UIImage(named: "not-available")) {
                imageInputs.append(input)
            }
        }
        
        if imageInputs.count <= 0 {
            imageInputs.append(ImageSource(image: UIImage(named: "not-available")!))
        }

        return imageInputs
    }
    public var equipments: EquipmentModel?
    
    public var photosUrl: [String] {
        guard let photosURL = deal.photos else { return [] }
        return photosURL
    }
    
    public init(deal: Deal) {
        self.deal = deal
        if let equipments = deal.equipments {
            self.equipments = EquipmentModel(equipments: equipments)
        }
    }
}
