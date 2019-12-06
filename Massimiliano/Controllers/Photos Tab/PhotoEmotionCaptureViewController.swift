//
//  PhotoEmotionCaptureViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 11/2/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import RealmSwift

class PhotoEmotionCaptureViewController: UIViewController {
    
    @IBOutlet weak var emotionImage: UIImageView!
    @IBOutlet weak var previewView: MyAwesomeView!
    
    @IBOutlet weak var photoEmotionView: MyAwesomeView!
    @IBOutlet weak var emotionIcon: UIImageView!
    @IBOutlet weak var emotionName: UILabel!
    
    var photoInfo: ImageWithEmotion!
    var selectedIndex: Int! = 0
    var allPhotos : PHFetchResult<PHAsset>? = nil
    
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSwipUpDownGuesture()
        //self.emotionImage.image = UIImage(data: self.photoInfo.imageData)
        self.getQualityImage(identifier: self.photoInfo.identifier)
        // Do any additional setup after loading the view.
    }
    
    
    func getQualityImage(identifier: String) {
        
        let fetchOptions = PHFetchOptions()
        let singleImage = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: fetchOptions)
        let asset = singleImage.object(at: 0)
        

        //self.emotionImage.fetchImageQualityFormat(asset: asset, contentMode: .aspectFill)
        self.emotionImage.fetchImageQualityFormat(asset: asset, contentMode: .aspectFill)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Setup your camera here...
        self.captureSession = AVCaptureSession()
        self.captureSession.sessionPreset = .medium
        
        
        guard let frontCamera = self.getDevice(position: .front)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            
            self.stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                self.setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera: \(error.localizedDescription)")
        }
        
        self.getPhoto()
    }
    
    func setupLivePreview() {
        
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        self.videoPreviewLayer.videoGravity = .resizeAspectFill
        self.videoPreviewLayer.connection?.videoOrientation = .portrait
        self.previewView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }
    }
    
    func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices: NSArray = AVCaptureDevice.devices() as NSArray;
        for de in devices {
            let deviceConverted = de as! AVCaptureDevice
            if(deviceConverted.position == position){
               return deviceConverted
            }
        }
       return nil
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareImageEmotion(_ sender: Any) {
        
    }
    
    func addSwipUpDownGuesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            print("Swipe Left")
            self.changePicture(direction: .left)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")
            self.changePicture(direction: .right)
        }
    }
    
    func changePicture(direction: UISwipeGestureRecognizer.Direction) {
        
        if (direction == .left) && (self.selectedIndex < self.allPhotos!.count - 1) {
            self.selectedIndex = self.selectedIndex + 1
        } else if (direction == .right) && (self.selectedIndex > 0)  {
            self.selectedIndex = self.selectedIndex - 1
        }
        
        self.getQualityImage(identifier: (self.allPhotos?.object(at: self.selectedIndex).localIdentifier)!)
        
    }
    
    
    func detectFaces(photo: UIImage, completion: @escaping (_ emotion: Emotion) -> Void) {
        FaceAPI.detectFaces(facesPhoto: photo) { (result) in
            switch result {
            case .Success(let json):
                
                let detectedFaces = json as! JSONArray
                //print(json)
                
                var angerVal: Double = 0
                var fearVal: Double  = 0
                var happinessVal: Double  = 0
                var sadnessVal: Double  = 0
                var surpriseVal: Double  = 0
                
                for item in detectedFaces {
                    let face = item as! JSONDictionary
                    //let faceId = face["faceId"] as! String
                    let emotions = face["faceAttributes"]!["emotion"] as! [String: AnyObject]
                    
                    //print(emotions)
                    angerVal = angerVal + (emotions["anger"] as! Double)
                    fearVal = fearVal + (emotions["fear"] as! Double)
                    happinessVal = happinessVal + (emotions["happiness"] as! Double)
                    sadnessVal = sadnessVal + (emotions["sadness"] as! Double)
                    surpriseVal = surpriseVal + (emotions["surprise"] as! Double)
                }
                
                if ((angerVal > fearVal) && (angerVal > happinessVal) && (angerVal > sadnessVal) && (angerVal > surpriseVal)) {
                    completion(Emotion.anger)
                } else if ((fearVal > angerVal) && (fearVal > happinessVal) && (fearVal > sadnessVal) && (fearVal > surpriseVal)) {
                    completion(Emotion.fear)
                }  else if ((happinessVal > angerVal) && (happinessVal > fearVal) && (happinessVal > sadnessVal) && (happinessVal > surpriseVal)) {
                    completion(Emotion.happiness)
                }  else if ((sadnessVal > angerVal) && (sadnessVal > fearVal) && (sadnessVal > happinessVal) && (sadnessVal > surpriseVal)) {
                    completion(Emotion.sadness)
                }  else if ((surpriseVal > angerVal) && (surpriseVal > fearVal) && (surpriseVal > happinessVal) && (surpriseVal > sadnessVal)) {
                    completion(Emotion.surprise)
                } else {
                    completion(Emotion.neutral)
                }
                
            case .Failure(let error):
                print("DetectFaces error - ", error)
                DispatchQueue.main.async {

                }
                
                break
            }
        }
    }
    
    func getPhoto() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            self.stillImageOutput.capturePhoto(with: settings, delegate: self)
        })
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


extension PhotoEmotionCaptureViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = normalizeImageRotation(UIImage(data: imageData)!)

        
        self.detectFaces(photo: image) { (emotion) in
            print(emotion)
            
            let emotionImage = GalleryEmotionImage()
            emotionImage.imageName = self.photoInfo.identifier
            emotionImage.imageEmotion = emotion.rawValue
            
            // Get the default Realm
            let realm = try! Realm()
            // You only need to do this once (per thread)

            // Add to the Realm inside a transaction
            try! realm.write {
//                realm.add(emotionImage, update: true)
                realm.add(emotionImage, update: .all)
            }
            
            DispatchQueue.main.async {
              self.showEmotionLabel(emotion: emotion)
            }
        }
    }
    
    
    func showEmotionLabel(emotion: Emotion) {
        
        switch emotion {
        case .anger:
            self.emotionIcon.image = #imageLiteral(resourceName: "angeryFaceIcon")
            self.emotionName.text = "Anger"
        case .fear:
            self.emotionIcon.image = #imageLiteral(resourceName: "fearFaceIcon")
            self.emotionName.text = "Fear"
        case .happiness:
            self.emotionIcon.image = #imageLiteral(resourceName: "happinessFaceIcon")
            self.emotionName.text = "Happy"
        case .neutral:
            self.emotionIcon.image = #imageLiteral(resourceName: "neutralFaceIcon")
            self.emotionName.text = "Neutral"
        case .sadness:
            self.emotionIcon.image = #imageLiteral(resourceName: "sadFaceIcon")
            self.emotionName.text = "Sad"
        case .surprise:
            self.emotionIcon.image = #imageLiteral(resourceName: "surpriseFaceIcon")
            self.emotionName.text = "Surprise"
        }
        
        UIView.animate(withDuration: 1) {
            self.photoEmotionView.alpha = 1
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        // dispose system shutter sound
        AudioServicesDisposeSystemSoundID(1108)
    }
    
    func normalizeImageRotation(_ image: UIImage) -> UIImage {
        if (image.imageOrientation == UIImage.Orientation.up) { return image }

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}



//Delete Relam

//let realm = try! Realm()
//try! realm.write {
//  realm.deleteAll()
//}
