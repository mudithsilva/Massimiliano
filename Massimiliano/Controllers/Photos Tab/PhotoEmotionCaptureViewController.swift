//
//  PhotoEmotionCaptureViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 11/2/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoEmotionCaptureViewController: UIViewController {
    
    @IBOutlet weak var emotionImage: UIImageView!
    @IBOutlet weak var previewView: MyAwesomeView!
    
    var photoInfo: ImageWithEmotion!
    
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emotionImage.image = UIImage(data: self.photoInfo.imageData)
        // Do any additional setup after loading the view.
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
    
    
    func detectFaces(photo: UIImage, completion: @escaping (_ emotion: Emotion) -> Void) {
        FaceAPI.detectFaces(facesPhoto: photo) { (result) in
            switch result {
            case .Success(let json):
                
                let detectedFaces = json as! JSONArray
                print(json)
                for item in detectedFaces {
                    let face = item as! JSONDictionary
                    let faceId = face["faceId"] as! String
                    let emotions = face["faceAttributes"]!["emotion"] as! [String: AnyObject]
                    
                    print(emotions)
                    
//                    let detectedFace = Face(faceId: faceId,
//                                            height: rectangle["top"] as! Int,
//                                            width: rectangle["width"] as! Int,
//                                            top: rectangle["top"] as! Int,
//                                            left: rectangle["left"] as! Int)
                }
                completion(Emotion.anger)
                break
            case .Failure(let error):
                print("DetectFaces error - ", error)
                DispatchQueue.main.async {

                }
                
                break
            }
        }
    }
    
    func getPhoto() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
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
