//
//  HomeViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/28/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var photosTab: UIView!
    @IBOutlet weak var moodsTab: UIView!
    @IBOutlet weak var settingsTab: UIView!
    
    @IBOutlet weak var photoTabLabel: UILabel!
    @IBOutlet weak var moodsTabLabel: UILabel!
    @IBOutlet weak var settingsTabLabel: UILabel!
    
    @IBOutlet weak var photoTabImg: UIImageView!
    @IBOutlet weak var moodsTabImg: UIImageView!
    @IBOutlet weak var settingsTabImg: UIImageView!
    
    private let selectedTabColor: UIColor = #colorLiteral(red: 0.3536440134, green: 0.3536530137, blue: 0.3536481857, alpha: 1)
    private let deselectedTabColor: UIColor = #colorLiteral(red: 0.8077236414, green: 0.8077427745, blue: 0.8077324033, alpha: 1)
    
    private let photoTabSelectedImg: UIImage = #imageLiteral(resourceName: "photoTabSelected")
    private let photoTabDeselectImg: UIImage = #imageLiteral(resourceName: "photoTabDeselect")
    
    private let moodsTabSelectedImg: UIImage = #imageLiteral(resourceName: "moodTabSelect")
    private let moodsTabDeselectedImg: UIImage = #imageLiteral(resourceName: "moodTabDeselect")
    
    private let settingsTabSelectedImg: UIImage = #imageLiteral(resourceName: "settingTabSelect")
    private let settingsTabDeselectedImg: UIImage = #imageLiteral(resourceName: "settingsTabDeselect")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTabView()
        // Do any additional setup after loading the view.
    }
    
    func configTabView() {
        self.photosTab.alpha = 0
        self.moodsTab.alpha = 0
        self.settingsTab.alpha = 0
        
        self.clickedPhotoTab(UIButton())
    }
    
    @IBAction func clickedPhotoTab(_ sender: Any) {
        self.photoTabLabel.textColor = self.selectedTabColor
        self.photoTabImg.image = self.photoTabSelectedImg
        
        self.moodsTabLabel.textColor = self.deselectedTabColor
        self.moodsTabImg.image = self.moodsTabDeselectedImg
        
        self.settingsTabLabel.textColor = self.deselectedTabColor
        self.settingsTabImg.image = self.settingsTabDeselectedImg
        
        self.photosTab.alpha = 1
        self.moodsTab.alpha = 0
        self.settingsTab.alpha = 0
    }
    
    @IBAction func clickedMoodsTab(_ sender: Any) {
        self.photoTabLabel.textColor = self.deselectedTabColor
        self.photoTabImg.image = self.photoTabDeselectImg
        
        self.moodsTabLabel.textColor = self.selectedTabColor
        self.moodsTabImg.image = self.moodsTabSelectedImg
        
        self.settingsTabLabel.textColor = self.deselectedTabColor
        self.settingsTabImg.image = self.settingsTabDeselectedImg
        
        self.photosTab.alpha = 0
        self.moodsTab.alpha = 1
        self.settingsTab.alpha = 0
    }
    
    @IBAction func clickedSettingsTab(_ sender: Any) {
        self.photoTabLabel.textColor = self.deselectedTabColor
        self.photoTabImg.image = self.photoTabDeselectImg
        
        self.moodsTabLabel.textColor = self.deselectedTabColor
        self.moodsTabImg.image = self.moodsTabDeselectedImg
        
        self.settingsTabLabel.textColor = self.selectedTabColor
        self.settingsTabImg.image = self.settingsTabSelectedImg
        
        self.photosTab.alpha = 0
        self.moodsTab.alpha = 0
        self.settingsTab.alpha = 1
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
