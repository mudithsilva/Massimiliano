//
//  SettingsViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 1/30/20.
//  Copyright © 2020 Chathuranga. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotToSubscribtion(_ sender: Any) {
        self.performSegue(withIdentifier: "showIAP", sender: nil)
        //self.navigationController?.popViewController(animated: true)
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
