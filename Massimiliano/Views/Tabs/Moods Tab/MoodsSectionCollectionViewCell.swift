//
//  MoodsSectionCollectionViewCell.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class MoodsSectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moodImage: UIImageView!
    @IBOutlet weak var moodName: UILabel!
    
    @IBOutlet weak var moodImageCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.moodImage.image = UIImage(named: "") // Add Placeholder Image
        self.moodName.text = ""
    }

}
