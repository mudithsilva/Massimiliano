//
//  MoodPhotoViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 12/1/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit
import Photos
import RealmSwift

class MoodPhotoViewController: UIViewController {
    
    @IBOutlet weak var emotionImage: UIImageView!
    
    var photoInfo: ImageWithEmotion!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getQualityImage()
    }
    
    func getQualityImage() {
        
        let fetchOptions = PHFetchOptions()
        let singleImage = PHAsset.fetchAssets(withLocalIdentifiers: [self.photoInfo.identifier], options: fetchOptions)
        let asset = singleImage.object(at: 0)
        
        self.emotionImage.fetchImageQualityFormat(asset: asset, contentMode: .aspectFill)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
