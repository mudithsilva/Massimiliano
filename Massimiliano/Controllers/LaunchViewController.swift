//
//  LaunchViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/27/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit
import Photos
import RealmSwift

class LaunchViewController: UIViewController {
    
    private var didShowWalkMe: Bool {
        get {
            let userInfo = AppData.getData(key: UserData.didShowWalkMe)
            if userInfo == "true" {
                return true
            } else {
                return false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.deleteAllData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (self.didShowWalkMe) {
            self.loadGalleryPhotos()
            //self.performSegue(withIdentifier: "showHomePath", sender: nil)
        } else {
            self.performSegue(withIdentifier: "showNewUserPath", sender: nil)
        }
    }
    
    func loadGalleryPhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .notDetermined, .restricted, .denied, .authorized:
                DispatchQueue.main.async {
                  self.performSegue(withIdentifier: "showHomePath", sender: nil)
                }
            @unknown default:
                print("Error!")
                fatalError()
            }
        }
    }
    
    func deleteAllData() {
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
    }
    

}
