//
//  PhotoGalleryCollectionViewCell.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class PhotoGalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryImage: UIImageView!
    
    var parentVC: PhotosTabViewController!
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
