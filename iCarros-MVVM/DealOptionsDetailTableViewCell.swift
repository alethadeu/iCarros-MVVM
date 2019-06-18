//
//  DealOptionsDetailTableViewCell.swift
//  iCarros-MVVM
//
//  Created by Alexandre Thadeu on 17/06/19.
//  Copyright © 2019 Alexandre Thadeu. All rights reserved.
//

import UIKit

class DealOptionsDetailTableViewCell: UITableViewCell {
        
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(category: String, items: [String]) {
        categoryLabel.text = category
        var description = ""
        for item in items {
            description += "\(item)\n"
        }
        itemsLabel.text = description
    }

}
