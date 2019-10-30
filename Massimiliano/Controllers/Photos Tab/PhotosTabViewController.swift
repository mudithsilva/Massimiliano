//
//  PhotosTabViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class PhotosTabViewController: UIViewController {
    
    @IBOutlet weak var galleryImageCollectionView: UICollectionView!
    
    private let tempImage: UIImage = #imageLiteral(resourceName: "sampleGalleryImage")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        // Do any additional setup after loading the view.
    }
    
    func registerNibs() {
        self.galleryImageCollectionView.register(UINib(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
    }
    

}

extension PhotosTabViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width - 15.0) / 4, height: (self.view.frame.size.width - 15.0) / 4)
    }
    
}

extension PhotosTabViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryCollectionViewCell", for: indexPath) as! PhotoGalleryCollectionViewCell
        cell.galleryImage.image = self.tempImage
        return cell
    }
    
    
}
