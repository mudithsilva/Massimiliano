//
//  MoodsTabViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit
import RealmSwift
import Photos

class MoodsTabViewController: UIViewController {
    
    @IBOutlet weak var moodsCollectionView: UICollectionView!
    
    private var moodImages: [UIImage] = [#imageLiteral(resourceName: "sampleMood1"), #imageLiteral(resourceName: "sampleMood2"), #imageLiteral(resourceName: "sampleMood1"), #imageLiteral(resourceName: "sampleMood2"), #imageLiteral(resourceName: "sampleMood1"), #imageLiteral(resourceName: "sampleMood2")]
    private let moodNames: [String] = ["Happy Times","Anger","Sad Times","Surprices", "Fear", "Neutral"]
    private let moodType: [String] = ["happiness","anger","sadness","surprise", "fear", "neutral"]
    private var moodTypeCount: [String] = ["Loading ...", "Loading ...", "Loading ...", "Loading ...", "Loading ...", "Loading ..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getEmotionCount()
    }
    
    func registerNibs() {
        self.moodsCollectionView.register(UINib(nibName: "MoodsSectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoodsSectionCollectionViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEmotionImages" {
            let index = sender as! Int
            let destinationVC = segue.destination as! SelectedMoodPhotosViewController
            destinationVC.selectedMoodName = self.moodNames[index]
            destinationVC.selectedMoodType = self.moodType[index]
        }
    }
    
    func getEmotionCount() {
        
        var tempMoodTypeCount: [String] = []
        var moodIndex :Int = 0
        
        for mood in moodType {
            var imageNames: [String] = []
            
            let realm = try! Realm()
            let happyImages = realm.objects(GalleryEmotionImage.self).filter("imageEmotion = '\(mood)'")
            
            for item in happyImages {
                imageNames.append(item.imageName)
            }
            
            let fetchOptions = PHFetchOptions()
            let allPhotos = PHAsset.fetchAssets(withLocalIdentifiers: imageNames, options: fetchOptions)
            
            tempMoodTypeCount.append("\(allPhotos.count) Contents Found")
            
            if allPhotos.count > 0 {
                self.moodImages[moodIndex] = self.convertImageFromAsset(asset: allPhotos.firstObject!)
            } else {
                self.moodImages[moodIndex] = UIImage(named: "sampleMood1")!
            }
            moodIndex = moodIndex + 1
        }
        
        self.moodTypeCount = tempMoodTypeCount
        
        DispatchQueue.main.async {
          self.moodsCollectionView.reloadData()
        }
    }
    
    func convertImageFromAsset(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var image = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            image = result!
        })
        return image
    }
    

}

extension MoodsTabViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width - 60.0) / 2, height: 300.0)
    }
    
}

extension MoodsTabViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moodNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodsSectionCollectionViewCell", for: indexPath) as! MoodsSectionCollectionViewCell
        
        cell.moodImage.image = self.moodImages[indexPath.row]
        cell.moodName.text = self.moodNames[indexPath.row]
        cell.moodImageCount.text = self.moodTypeCount[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showEmotionImages", sender: indexPath.row)
    }
    
    
}
