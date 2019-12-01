//
//  SelectedMoodPhotoCollectionViewCell.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 11/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class SelectedMoodPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryImage: UIImageView!
    
    var parentVC: SelectedMoodPhotosViewController!
    var identifier: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.galleryImage.image = UIImage(named: "") // Add Placeholder Image
    }
    
    @IBAction func clickedImage(_ sender: Any) {
        self.parentVC.showImageEmotionView(image: self.galleryImage.image!, identifier: self.identifier)
    }

}
