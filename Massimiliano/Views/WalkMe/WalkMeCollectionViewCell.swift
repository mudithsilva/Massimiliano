//
//  WalkMeCollectionViewCell.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/27/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class WalkMeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.title.text = ""
    }
}
