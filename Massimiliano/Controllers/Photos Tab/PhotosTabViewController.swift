//
//  PhotosTabViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit
import Photos

class PhotosTabViewController: UIViewController {
    
    @IBOutlet weak var galleryImageCollectionView: UICollectionView!
    
    private let tempImage: UIImage = #imageLiteral(resourceName: "sampleGalleryImage")
    private var allPhotos : PHFetchResult<PHAsset>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        self.loadGalleryPhotos()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.galleryImageCollectionView.reloadData()
    }
    
    func registerNibs() {
        self.galleryImageCollectionView.register(UINib(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
    }
    
    func loadGalleryPhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed!")
                let fetchOptions = PHFetchOptions()
                self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                DispatchQueue.main.async {
                  self.galleryImageCollectionView.reloadData()
                }
            case .denied, .restricted:
                print("Not allowed!")
            case .notDetermined:
                print("Not determined yet!")
            @unknown default:
                print("Error!")
                fatalError()
            }
        }
    }
    
    func showImageEmotionView(image: UIImage, identifier: String) {
        let imageInfo = ImageWithEmotion(identifier: identifier, imageData: image.pngData()!)
        self.performSegue(withIdentifier: "showPhotoView", sender: imageInfo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showPhotoView") {
            let photoInfo = sender as! ImageWithEmotion
            let destinationVC = segue.destination as! PhotoEmotionCaptureViewController
            destinationVC.photoInfo = photoInfo
        }
    }
    

}

extension PhotosTabViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width - 15.0) / 4, height: (self.view.frame.size.width - 15.0) / 4)
    }
    
}

extension PhotosTabViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryCollectionViewCell", for: indexPath) as! PhotoGalleryCollectionViewCell
        //cell.galleryImage.image = self.tempImage
        
        let asset = self.allPhotos?.object(at: indexPath.row)
        cell.galleryImage.fetchImage(asset: asset!, contentMode: .aspectFill)
        cell.parentVC = self
        cell.identifier = self.allPhotos?.object(at: indexPath.row).localIdentifier
        //print(self.allPhotos?.object(at: indexPath.row).localIdentifier!)
        
        return cell
    }
    
    
}

extension UIImageView{
 func fetchImage(asset: PHAsset, contentMode: PHImageContentMode) {
    let options = PHImageRequestOptions()
    options.version = .original
    PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: contentMode, options: options) { image, _ in
        guard let image = image else { return }
        switch contentMode {
        case .aspectFill:
            self.contentMode = .scaleAspectFill
        case .aspectFit:
            self.contentMode = .scaleAspectFit
        @unknown default:
            print("Error!")
            fatalError()
        }
        self.image = image
    }
   }
}