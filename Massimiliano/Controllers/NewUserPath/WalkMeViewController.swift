//
//  WalkMeViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/27/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class WalkMeViewController: UIViewController {
    
    @IBOutlet weak var walkmeCollectionView: UICollectionView!
    @IBOutlet weak var iPhoneImage :UIImageView!
    
    @IBOutlet weak var selection1: UIView!
    @IBOutlet weak var selection2: UIView!
    @IBOutlet weak var selection3: UIView!
    
    private var titles: [String] = ["Smarter albums for all of your adventures",
                                    "Record trips anywhere even without data access",
                                    "Tag your best moments with realtime emotions"]
    
    private var imagesArray: [String] = ["iPhoneImage1",
                                         "iPhoneImage2",
                                         "iPhoneImage3"]
    
    var selectedColor: UIColor = #colorLiteral(red: 0.0862745098, green: 0.5176470588, blue: 0.9921568627, alpha: 1)
    var deselectColor: UIColor = #colorLiteral(red: 0.04705882353, green: 0.4470588235, blue: 0.8784313725, alpha: 0.3)
    
    var foucusedIndex: Int = 0 {
        didSet {
            self.changeCardImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        self.changeCardImage()
        // Do any additional setup after loading the view.
    }
    
    func registerNibs() {
        self.walkmeCollectionView.register(UINib(nibName: "WalkMeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WalkMeCollectionViewCell")
    }
    
    @IBAction func clickedGetStarted(_ sender: Any) {
        AppData.storeData(data: "true", key: UserData.didShowWalkMe)
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        let pageWidth:Float = Float(self.view.frame.size.width + 10.0) // Your cell Width + Min Spacing for Lines
        
        
        let currentOffSet:Float = Float(scrollView.contentOffset.x)
        let targetOffSet:Float = Float(targetContentOffset.pointee.x)
        
        var newTargetOffset:Float = 0
        
        if(targetOffSet > currentOffSet) {
            newTargetOffset = ((currentOffSet / pageWidth).rounded(.up) * (pageWidth))
            //            self.foucusedIndex = Int((currentOffSet / pageWidth).rounded(.up))
        } else if(targetOffSet < currentOffSet) {
            newTargetOffset = ((currentOffSet / pageWidth).rounded(.down) * (pageWidth))
            //            self.foucusedIndex = Int((currentOffSet / pageWidth).rounded(.down))
        } else {
            newTargetOffset = ((currentOffSet / pageWidth).rounded(.toNearestOrAwayFromZero) * (pageWidth))
            //            self.foucusedIndex = Int((currentOffSet / pageWidth).rounded(.toNearestOrAwayFromZero))
        }
        
        if(newTargetOffset < 0){
            newTargetOffset = 0
        } else if (newTargetOffset > Float(scrollView.contentSize.width)) {
            newTargetOffset = Float(scrollView.contentSize.width)
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffSet)
        scrollView.setContentOffset(CGPoint(x: Int(newTargetOffset), y: 0), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth:Float = Float(self.view.frame.size.width + 10.0) // Your cell Width + Min Spacing for Lines
        
        let currentOffSet:Float = Float(scrollView.contentOffset.x)
        
        if self.foucusedIndex != Int((currentOffSet / pageWidth).rounded(.toNearestOrAwayFromZero)) {
            self.foucusedIndex = Int((currentOffSet / pageWidth).rounded(.toNearestOrAwayFromZero))
            //            NotificationCenter.default.post(name: .didChangeWalkMeCard, object: nil, userInfo: ["activeView": self.foucusedIndex])
            //            self.cardView.reloadData()
        }
    }
    
    func changeCardImage() {
        self.iPhoneImage.image = UIImage(named: self.imagesArray[self.foucusedIndex])
        if (self.foucusedIndex == 0) {
            self.selection1.backgroundColor = self.selectedColor
            self.selection2.backgroundColor = self.deselectColor
            self.selection3.backgroundColor = self.deselectColor
        } else if (self.foucusedIndex == 1) {
            self.selection1.backgroundColor = self.deselectColor
            self.selection2.backgroundColor = self.selectedColor
            self.selection3.backgroundColor = self.deselectColor
        } else {
            self.selection1.backgroundColor = self.deselectColor
            self.selection2.backgroundColor = self.deselectColor
            self.selection3.backgroundColor = self.selectedColor
        }
    }
    
    
}

extension WalkMeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
}

extension WalkMeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkMeCollectionViewCell", for: indexPath) as! WalkMeCollectionViewCell
        cell.title.text = self.titles[indexPath.row]
        return cell
    }
    
    
}
