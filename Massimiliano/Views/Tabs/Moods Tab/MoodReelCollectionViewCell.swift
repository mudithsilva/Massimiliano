//
//  MoodReelCollectionViewCell.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 1/22/20.
//  Copyright © 2020 Chathuranga. All rights reserved.
//

import UIKit

class MoodReelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moodImage: UIImageView!
    @IBOutlet weak var moodname: UILabel!
    @IBOutlet weak var moodBG: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
