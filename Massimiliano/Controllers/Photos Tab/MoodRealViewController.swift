//
//  MoodRealViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 1/21/20.
//  Copyright © 2020 Chathuranga. All rights reserved.
//

import UIKit
import RealmSwift
import Photos

class MoodRealViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var reelName: UILabel!
    
    var mood: String = ""
    var imgListArray: [UIImage] = []
    var currentImageInd: Int = 0
    var moodTitle = ""

    var progress = Progress(totalUnitCount: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reelName.text = self.moodTitle
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getEmotionCount()
    }
    
    func configProgress() {
        self.progressBar.progress = 0
        self.progress.completedUnitCount = 0
        
        self.progressBar.setProgress(Float(self.progress.fractionCompleted), animated: true)
    }
    
    
    func getEmotionCount() {
        var imageNames: [String] = []
        
        let realm = try! Realm()
        let imageSet = realm.objects(GalleryEmotionImage.self).filter("imageEmotion = '\(mood)'")
        
        self.progress = Progress(totalUnitCount: Int64(imageSet.count))
        self.configProgress()
        
        if imageSet.count > 0 {
            for item in imageSet {
                imageNames.append(item.imageName)
            }
            
            let fetchOptions = PHFetchOptions()
            let allPhotos = PHAsset.fetchAssets(withLocalIdentifiers: imageNames, options: fetchOptions)
            
            for val in 0...allPhotos.count - 1 {
                let image  = self.convertImageFromAsset(asset: allPhotos[val])
                self.imgListArray.append(image)
            }
            
            self.imageView.image = self.imgListArray[self.currentImageInd]
            self.progress.completedUnitCount += 1
            self.progressBar.setProgress(Float(self.progress.fractionCompleted), animated: true)
            self.changePhotos()
            
//            self.imageView.animationImages = imgListArray
//            self.imageView.animationDuration = Double(5 * allPhotos.count)
//            self.imageView.animationRepeatCount = 0
//            self.imageView.startAnimating()
//
//            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
//                guard self.progress.isFinished == false else {
//                    self.dismiss(animated: true, completion: nil)
//                    timer.invalidate()
//                    self.imageView.stopAnimating()
//                    return
//                }
//
//                self.progress.completedUnitCount += 1
//                self.progressBar.setProgress(Float(self.progress.fractionCompleted), animated: true)
//            }
        } else {
            print("Show Error Message")
            let alert = AlertController(viewController: self)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.showOneAlert(title: "No Photos Found!", message: "No Photos found on Mood :- \(moodTitle)", button: okAction)
        }
    }
    
    func changePhotos() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            guard self.currentImageInd != (self.imgListArray.count - 1) else {
                //self.dismiss(animated: true, completion: nil)
                timer.invalidate()
                return
            }
            self.currentImageInd += 1
            self.progress.completedUnitCount += 1
            
            UIView.transition(with: self.imageView,
                              duration: 0.5,
                              options: .transitionFlipFromRight,
                              animations: { self.imageView.image = self.imgListArray[self.currentImageInd] },
                              completion: { (completed) in
                                self.progressBar.setProgress(Float(self.progress.fractionCompleted), animated: true)
            })
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
    
    @IBAction func closeTab(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
