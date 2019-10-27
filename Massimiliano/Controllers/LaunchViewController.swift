//
//  LaunchViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/27/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

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

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (self.didShowWalkMe) {
            self.performSegue(withIdentifier: "showHomePath", sender: nil)
        } else {
            self.performSegue(withIdentifier: "showNewUserPath", sender: nil)
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
