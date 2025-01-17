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
import CoreLocation

class PhotoEmotionCaptureViewController: UIViewController {
    
    @IBOutlet weak var emotionImage: UIImageView!
    @IBOutlet weak var previewView: MyAwesomeView!
    
    @IBOutlet weak var photoEmotionView: MyAwesomeView!
    @IBOutlet weak var emotionName: UILabel!
    
    private let emojiArray: [String] = ["😊","😡","😢","😯","😨","😐"]
    
    var photoInfo: ImageWithEmotion!
    var selectedIndex: Int! = 0
    var allPhotos : PHFetchResult<PHAsset>? = nil
    var photoAddress: String = ""
    var photoDate: String = ""
    
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var videoPanGuest: UIPanGestureRecognizer = UIPanGestureRecognizer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSwipUpDownGuesture()
        //self.emotionImage.image = UIImage(data: self.photoInfo.imageData)
        self.getQualityImage(identifier: self.photoInfo.identifier)
        self.configPanGuest()
        // Do any additional setup after loading the view.
    }
    
    
    func getQualityImage(identifier: String) {
        
        UIView.animate(withDuration: 0.5) {
            self.photoEmotionView.alpha = 0
        }
        
        let fetchOptions = PHFetchOptions()
        let singleImage = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: fetchOptions)
        let asset = singleImage.object(at: 0)
        

        //self.emotionImage.fetchImageQualityFormat(asset: asset, contentMode: .aspectFill)
        self.emotionImage.fetchImageQualityFormat(asset: asset, contentMode: .aspectFill)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if asset.creationDate != nil {
            self.photoDate = formatter.string(from: asset.creationDate!)
        }
        
        if asset.location != nil {
            self.getPicLocation(lat: asset.location!.coordinate.latitude,
                                long: asset.location!.coordinate.longitude)
        }
        
        
        self.getPhoto()
        
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
        
        //self.getPhoto()
    }
    
    func configPanGuest() {
        self.videoPanGuest = UIPanGestureRecognizer(target: self, action: #selector(draggedView))
        self.previewView.isUserInteractionEnabled = true
        self.previewView.addGestureRecognizer(self.videoPanGuest)
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(self.previewView)
        let translation = sender.translation(in: self.view)
        self.previewView.center = CGPoint(x: self.previewView.center.x + translation.x, y: self.previewView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
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
                //print(detectedFaces)
                
                if detectedFaces.count == 0 {
                    print("Show Error")
                    DispatchQueue.main.async {
                        let alert = AlertController(viewController: self)
                        let okAction: UIAlertAction = UIAlertAction(title: "OKAY", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                            self.getPhoto()
                        })
                        alert.showOneAlert(title: "Hold your phone properly!", message: "Laborum cupidatat consectetur proident culpa eu labore dolor duis", button: okAction)
                        
                    }
                } else {
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
    
    func getPicLocation(lat: Double, long: Double) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: lat, longitude: long)) { (placemark, error) in
            print(placemark!)
            if (error != nil) {
                print("reverse geodcode fail")
            }
            let pm = placemark! as [CLPlacemark]
            if pm.count > 0 {
                let pm = placemark![0]
                if pm.subLocality != nil {
                    self.photoAddress = self.photoAddress + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    self.photoAddress = self.photoAddress + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    self.photoAddress = self.photoAddress + pm.locality! + ", "
                }
                if pm.country != nil {
                    self.photoAddress = self.photoAddress + pm.country! + ", "
                }
                self.photoAddress = self.photoAddress.lowercased()
            }
        }
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
            emotionImage.imageName = (self.allPhotos?.object(at: self.selectedIndex).localIdentifier)!
            emotionImage.imageEmotion = emotion.rawValue
            emotionImage.imageLocation = self.photoAddress
            emotionImage.imageDate = self.photoDate
            
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
            self.emotionName.text = self.emojiArray[1]
        case .fear:
            self.emotionName.text = self.emojiArray[4]
        case .happiness:
            self.emotionName.text = self.emojiArray[0]
        case .neutral:
            self.emotionName.text = self.emojiArray[5]
        case .sadness:
            self.emotionName.text = self.emojiArray[2]
        case .surprise:
            self.emotionName.text = self.emojiArray[3]
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

extension PhotoEmotionCaptureViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.emotionImage
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
            if scrollView.zoomScale > 1 {
            if let image = self.emotionImage.image {

                let ratioW = self.emotionImage.frame.width / image.size.width
                let ratioH = self.emotionImage.frame.height / image.size.height

                let ratio = ratioW < ratioH ? ratioW : ratioH

                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio

                let left = 0.5 * (newWidth * scrollView.zoomScale > self.emotionImage.frame.width ? (newWidth - self.emotionImage.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                let top = 0.5 * (newHeight * scrollView.zoomScale > self.emotionImage.frame.height ? (newHeight - self.emotionImage.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))

                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
                self.stillImageOutput.capturePhoto(with: settings, delegate: self)
            })
        }
    }
}



//Delete Relam

//let realm = try! Realm()
//try! realm.write {
//  realm.deleteAll()
//}
