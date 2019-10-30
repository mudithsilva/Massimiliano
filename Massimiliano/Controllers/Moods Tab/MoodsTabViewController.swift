//
//  MoodsTabViewController.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 10/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import UIKit

class MoodsTabViewController: UIViewController {
    
    @IBOutlet weak var moodsCollectionView: UICollectionView!
    
    private let moodImages: [UIImage] = [#imageLiteral(resourceName: "sampleMood1"), #imageLiteral(resourceName: "sampleMood2"), #imageLiteral(resourceName: "sampleMood1"), #imageLiteral(resourceName: "sampleMood2")]
    private let moodNames: [String] = ["Happy Times","Excitments","Sad Times","Surprices"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        // Do any additional setup after loading the view.
    }
    
    func registerNibs() {
        self.moodsCollectionView.register(UINib(nibName: "MoodsSectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoodsSectionCollectionViewCell")
    }
    

}

extension MoodsTabViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width) / 3, height: 300.0)
    }
    
}

extension MoodsTabViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moodNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodsSectionCollectionViewCell", for: indexPath) as! MoodsSectionCollectionViewCell
        
        cell.moodImage.image = self.moodImages[indexPath.row]
        cell.moodName.text = self.moodNames[indexPath.row]
        cell.moodImageCount.text = "50 Contents Found"
        return cell
    }
    
    
}
