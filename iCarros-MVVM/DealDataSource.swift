//
//  DealDataSource.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 17/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import Foundation
import UIKit

protocol InteractDealDelegate: class {
    func returnDealWhenClickOnPhoto(deal: DealModel)
}

class DealDataSource: GenericDataSource<DealModel>, UICollectionViewDataSource, DealCollectionPhotoDelegate {
    
    weak var delegate: InteractDealDelegate?
    
    func slideShowTapped(cell: DealCollectionViewCell) {
        guard let deal = cell.retrieveDeal() else { return }
        delegate?.returnDealWhenClickOnPhoto(deal: deal)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dealCollectionViewCell", for: indexPath) as? DealCollectionViewCell else { return UICollectionViewCell()
            
        }
        
        DispatchQueue.main.async {
            cell.setDeal(deal: self.data.value[indexPath.row])
            cell.addBorderOnCell()
            cell.addShadowOnCell()
            cell.layoutIfNeeded()
            cell.delegate = self
        }

        
        return cell
    }
    
    func retrieveDeal(index: Int) -> DealModel {
        return self.data.value[index]
    }
    
}
