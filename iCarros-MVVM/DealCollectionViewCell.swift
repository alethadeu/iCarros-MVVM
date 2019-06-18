//
//  DealCollectionViewCell.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 14/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import UIKit
import ImageSlideshow

protocol  DealCollectionPhotoDelegate: class {
    func slideShowTapped(cell: DealCollectionViewCell)
}

class DealCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DealCollectionPhotoDelegate?
    
    private var deal: DealModel? {
        didSet {
            
            if let imageInputs = deal?.photos {
                imageSlideShowView.setImageInputs(imageInputs)
            } else {
                imageSlideShowView.setImageInputs([ImageSource(image: UIImage(named: "not-available")!)])
            }
            
            dealMakeLabel.text          = deal?.make
            dealModelLabel.text         = deal?.model
            dealYearLabel.text          = deal?.year
            dealColorLabel.text         = deal?.color
            dealGearLabel.text          = deal?.gear
            dealFuelLabel.text          = deal?.fuel
        }
    }
    
    @IBOutlet weak var imageSlideShowView: ImageSlideshow! {
        didSet {
            imageSlideShowView.contentScaleMode = .scaleToFill
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
            pageIndicator.pageIndicatorTintColor = UIColor.black
            
            imageSlideShowView.pageIndicator = pageIndicator
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
        }
    }
    @IBOutlet weak var dealMakeLabel: UILabel!
    @IBOutlet weak var dealModelLabel: UILabel!
    @IBOutlet weak var dealTrimLabel: UILabel!
    @IBOutlet weak var dealYearLabel: UILabel!
    @IBOutlet weak var dealColorLabel: UILabel!
    @IBOutlet weak var dealGearLabel: UILabel!
    @IBOutlet weak var dealFuelLabel: UILabel!
    
    @IBOutlet var itemsViews: [UIView]! {
        didSet {
            for item in itemsViews {
                item.layer.cornerRadius = 5
            }
        }
    }
    
    @IBOutlet var icons: [UIImageView]! {
        didSet {
            for icon in icons {
                icon.changePngColorTo(color: .white)
            }
        }
    }
    
    func setDeal(deal: DealModel) {
        self.deal = deal
    }
    
    @objc func cellTapped(sender: AnyObject) {
        delegate?.slideShowTapped(cell: self)
    }
    
    func retrieveDeal() -> DealModel? {
        return deal
    }

}
