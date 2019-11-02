//
//  PhotoEmotionCaptureViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 11/2/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class PhotoEmotionCaptureViewController: UIViewController {
    
    @IBOutlet weak var emotionImage: UIImageView!
    
    var photoInfo: ImageWithEmotion!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emotionImage.image = UIImage(data: self.photoInfo.imageData)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    
    @IBAction func shareImageEmotion(_ sender: Any) {
        
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
