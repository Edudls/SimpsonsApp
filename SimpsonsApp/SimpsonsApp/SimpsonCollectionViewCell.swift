//
//  SimpsonCollectionViewCell.swift
//  SimpsonsApp
//
//  Created by C02GC0VZDRJL on 12/8/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import UIKit

class SimpsonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var selection: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
