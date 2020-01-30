//
//  PhotosTabViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit
import Photos
import RealmSwift

class PhotosTabViewController: UIViewController {
    
    @IBOutlet weak var galleryImageCollectionView: UICollectionView!
    @IBOutlet weak var moodsReelCollectionView: UICollectionView!
    @IBOutlet weak var searchField: MyAwesomeTextField!
    
    var quesryWaitingTimer = Timer()
    private let tempImage: UIImage = #imageLiteral(resourceName: "sampleGalleryImage")
    private var allPhotos : PHFetchResult<PHAsset>? = nil
    private var searchPhotos : PHFetchResult<PHAsset>? = nil
    
    private let emojiArray: [String] = ["😊","😡","😢","😯","😨","😐"]
    private let moodType: [String] = ["happiness","anger","sadness","surprise", "fear", "neutral"]
    private let moodReelImgs: [UIImage] = [#imageLiteral(resourceName: "happyIcon"),#imageLiteral(resourceName: "excitmentIcon"),#imageLiteral(resourceName: "happyIcon"),#imageLiteral(resourceName: "happyIcon"),#imageLiteral(resourceName: "sadtimeIcon"), #imageLiteral(resourceName: "surpriseIcon")]
    private let moodReelTag: [String] = ["#happy","#anger","#sadness","#surprise", "#fear", "#neutral"]
    
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        self.loadGalleryPhotos()
        self.addToolBar()
        self.searchField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged) // Detect changes on DatePicker
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.galleryImageCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.galleryImageCollectionView.reloadData()
    }
    
    func registerNibs() {
        self.galleryImageCollectionView.register(UINib(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoGalleryCollectionViewCell")
        self.moodsReelCollectionView.register(UINib(nibName: "MoodReelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoodReelCollectionViewCell")
    }
    
    @objc func searchTextChanged() {
        if self.searchField.text != "" {
            self.quesryWaitingTimer.invalidate()
            self.quesryWaitingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchQuery), userInfo: nil, repeats: false) // Waiting for type timer
        } else {
            self.quesryWaitingTimer.invalidate()
            self.searchPhotos = nil
            self.galleryImageCollectionView.reloadData()
        }
    }
    
    func addToolBar() {
        let toolbarSearch = UIToolbar()
        toolbarSearch.sizeToFit()
        
        let cancelSearchButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelSearch))
        let doneSearchButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSearch))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbarSearch.setItems([cancelSearchButton,spaceButton, doneSearchButton], animated: false)
        
        self.searchField.inputAccessoryView = toolbarSearch
    }
    
    @objc func cancelSearch() {
        self.view.endEditing(true)
        self.searchField.text = ""
        self.searchPhotos = nil
        self.galleryImageCollectionView.reloadData()
    }
    
    @objc func doneSearch() {
        self.view.endEditing(true)
    }
    
    @objc func searchQuery() {
        var imageNames: [String] = []
        
        let realm = try! Realm()
        let imageSet = realm.objects(GalleryEmotionImage.self).filter("imageEmotion BEGINSWITH '\(self.searchField.text!.lowercased())' OR imageLocation BEGINSWITH '\(self.searchField.text!.lowercased())' OR imageDate BEGINSWITH '\(self.searchField.text!.lowercased())'")
        
        if imageSet.count > 0 {
            for item in imageSet {
                imageNames.append(item.imageName)
            }
            
            let fetchOptions = PHFetchOptions()
            self.searchPhotos = PHAsset.fetchAssets(withLocalIdentifiers: imageNames, options: fetchOptions)
        } else {
            print("Show Error Message")
            self.searchPhotos = nil
        }
        self.galleryImageCollectionView.reloadData()
    }
    
    
    func loadGalleryPhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed!")
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
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
            destinationVC.selectedIndex = self.selectedIndex
            destinationVC.allPhotos = self.allPhotos
        } else if (segue.identifier == "showMoodReal") {
            let ind = sender as! IndexPath
            let destinationVC = segue.destination as! MoodRealViewController
            destinationVC.moodTitle = self.moodReelTag[ind.row]
            destinationVC.mood = self.moodType[ind.row]
            
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

extension PhotosTabViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: (self.view.frame.size.width - 15.0) / 4, height: (self.view.frame.size.width - 15.0) / 4)
        } else {
            return CGSize(width: (self.view.frame.size.width - 50.0) / 4, height: self.moodsReelCollectionView.frame.size.height)
        }
    }
    
}

extension PhotosTabViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 2 {
            collectionView.deselectItem(at: indexPath, animated: true)
            self.performSegue(withIdentifier: "showMoodReal", sender: indexPath)
        }
    }
}



extension PhotosTabViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            if self.searchField.text!.isEmpty {
                return self.allPhotos?.count ?? 0
            } else {
                return self.searchPhotos?.count ?? 0
            }
        } else {
            return self.moodType.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryCollectionViewCell", for: indexPath) as! PhotoGalleryCollectionViewCell
            //cell.galleryImage.image = self.tempImage
            var asset: PHAsset = PHAsset()
            
            if self.searchField.text!.isEmpty {
                asset = (self.allPhotos?.object(at: indexPath.row))!
                cell.emojiLabel.text = self.getPhotoEmotion(imageName: (self.allPhotos?.object(at: indexPath.row).localIdentifier)!)
            } else {
                asset = (self.searchPhotos?.object(at: indexPath.row))!
                cell.emojiLabel.text = self.getPhotoEmotion(imageName: (self.searchPhotos?.object(at: indexPath.row).localIdentifier)!)
            }
            
            cell.galleryImage.fetchImageFastFormat(asset: asset, contentMode: .aspectFill)
            cell.parentVC = self
            cell.identifier = self.allPhotos?.object(at: indexPath.row).localIdentifier
            cell.photoIndex = indexPath.row
            //cell.emojiLabel.text = self.getPhotoEmotion(imageName: (self.allPhotos?.object(at: indexPath.row).localIdentifier)!)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodReelCollectionViewCell", for: indexPath) as! MoodReelCollectionViewCell
            cell.moodImage.image = self.moodReelImgs[indexPath.row]
            cell.moodname.text = self.moodReelTag[indexPath.row]
            return cell
        }
    }
    
    
}

extension UIImageView{
 func fetchImageQualityFormat(asset: PHAsset, contentMode: PHImageContentMode) {
    let options = PHImageRequestOptions()
    
    options.version = .current
    options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
    
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
    
     func fetchImageFastFormat(asset: PHAsset, contentMode: PHImageContentMode) {
        let options = PHImageRequestOptions()
        
    //    options.resizeMode = PHImageRequestOptionsResizeMode.exact
        options.version = .current
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
        
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
