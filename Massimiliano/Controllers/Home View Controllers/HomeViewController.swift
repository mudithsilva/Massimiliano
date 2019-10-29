//
//  HomeViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/28/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var photoTabLabel: UILabel!
    @IBOutlet weak var moodsTabLabel: UILabel!
    @IBOutlet weak var settingsTabLabel: UILabel!
    
    @IBOutlet weak var photoTabImg: UIImageView!
    @IBOutlet weak var moodsTabImg: UIImageView!
    @IBOutlet weak var settingsTabImg: UIImageView!
    
    var selectedTabColor: UIColor = #colorLiteral(red: 0, green: 0.5355854034, blue: 0.9033754468, alpha: 1)
    var deselectedTabColor: UIColor = #colorLiteral(red: 0.05042139441, green: 0.4379299283, blue: 0.5784627795, alpha: 1)
    
    var photoTabSelectedImg: UIImage = #imageLiteral(resourceName: "photoTabSelected")
    var photoTabDeselectImg: UIImage = #imageLiteral(resourceName: "photoTabDeselect")
    
    var moodsTabSelectedImg: UIImage = #imageLiteral(resourceName: "moodTabSelect")
    var moodsTabDeselectedImg: UIImage = #imageLiteral(resourceName: "moodTabDeselect")
    
    var settingsTabSelectedImg: UIImage = #imageLiteral(resourceName: "settingTabSelect")
    var settingsTabDeselectedImg: UIImage = #imageLiteral(resourceName: "settingsTabDeselect")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedPhotoTab(_ sender: Any) {
        self.photoTabLabel.textColor = self.selectedTabColor
        self.photoTabImg.image = self.photoTabSelectedImg
        
        self.moodsTabLabel.textColor = self.deselectedTabColor
        self.moodsTabImg.image = self.moodsTabDeselectedImg
        
        self.settingsTabLabel.textColor = self.deselectedTabColor
        self.settingsTabImg.image = self.settingsTabDeselectedImg
    }
    
    @IBAction func clickedMoodsTab(_ sender: Any) {
        self.photoTabLabel.textColor = self.deselectedTabColor
        self.photoTabImg.image = self.photoTabDeselectImg
        
        self.moodsTabLabel.textColor = self.selectedTabColor
        self.moodsTabImg.image = self.moodsTabSelectedImg
        
        self.settingsTabLabel.textColor = self.deselectedTabColor
        self.settingsTabImg.image = self.settingsTabDeselectedImg
    }
    
    @IBAction func clickedSettingsTab(_ sender: Any) {
        self.photoTabLabel.textColor = self.deselectedTabColor
        self.photoTabImg.image = self.photoTabDeselectImg
        
        self.moodsTabLabel.textColor = self.deselectedTabColor
        self.moodsTabImg.image = self.moodsTabDeselectedImg
        
        self.settingsTabLabel.textColor = self.selectedTabColor
        self.settingsTabImg.image = self.settingsTabSelectedImg
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
