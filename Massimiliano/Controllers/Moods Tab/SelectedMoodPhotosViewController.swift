//
//  SelectedMoodPhotosViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 11/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit
import Photos
import RealmSwift

class SelectedMoodPhotosViewController: UIViewController {
    
    @IBOutlet weak var galleryImageCollectionView: UICollectionView!
    @IBOutlet weak var moodName: UILabel!
    
    private let emojiArray: [String] = ["😊","😡","😢","😯","😨","😐"]
    private let moodType: [String] = ["happiness","anger","sadness","surprise", "fear", "neutral"]
    
    private let tempImage: UIImage = #imageLiteral(resourceName: "sampleGalleryImage")
    private var allPhotos : PHFetchResult<PHAsset>? = nil
    
    var selectedMoodName: String! = ""
    var selectedMoodType: String! = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        self.loadGalleryPhotos()
        self.moodName.text = self.selectedMoodName
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //self.galleryImageCollectionView.reloadData()
    }
    
    func registerNibs() {
        self.galleryImageCollectionView.register(UINib(nibName: "SelectedMoodPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SelectedMoodPhotoCollectionViewCell")
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadGalleryPhotos() {
        // Get the default Realm
        var photoIdentifiers: [String] = []
        
        let realm = try! Realm()
        let happyImages = realm.objects(GalleryEmotionImage.self).filter("imageEmotion = '\(self.selectedMoodType!)'")
        
        for item in happyImages {
            let photoItem = item
            photoIdentifiers.append(photoItem.imageName)
        }
        
        let fetchOptions = PHFetchOptions()
        self.allPhotos = PHAsset.fetchAssets(withLocalIdentifiers: photoIdentifiers, options: fetchOptions)
        DispatchQueue.main.async {
          self.galleryImageCollectionView.reloadData()
        }
    }
    
    func showImageEmotionView(image: UIImage, identifier: String) {
        let imageInfo = ImageWithEmotion(identifier: identifier, imageData: image.pngData()!)
        self.performSegue(withIdentifier: "showPhoto", sender: imageInfo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showPhoto") {
            let photoInfo = sender as! ImageWithEmotion
            let destinationVC = segue.destination as! MoodPhotoViewController
            destinationVC.photoInfo = photoInfo
        }
    }
    
    func getPhotoEmotion(imageName: String) -> String {
        let realm = try! Realm()
        let imageData = realm.objects(GalleryEmotionImage.self).filter("imageName = '\(imageName)'")
        if imageData.count > 0 {
            let emotionData = imageData.first!
            let emoIndex = self.moodType.firstIndex(of: emotionData.imageEmotion)!
            return self.emojiArray[emoIndex]
        } else {
            return ""
        }
    }
    

}

extension SelectedMoodPhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width - 15.0) / 4, height: (self.view.frame.size.width - 15.0) / 4)
    }
    
}

extension SelectedMoodPhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedMoodPhotoCollectionViewCell", for: indexPath) as! SelectedMoodPhotoCollectionViewCell
        
        let asset = self.allPhotos?.object(at: indexPath.row)
        cell.galleryImage.fetchImageFastFormat(asset: asset!, contentMode: .aspectFill)
        cell.parentVC = self
        cell.identifier = self.allPhotos?.object(at: indexPath.row).localIdentifier
        cell.emojiLabel.text = self.getPhotoEmotion(imageName: (self.allPhotos?.object(at: indexPath.row).localIdentifier)!)
        return cell
    }
}
