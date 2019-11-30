//
//  GalleryEmotionImage.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 11/30/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import Foundation
import RealmSwift

class GalleryEmotionImage: Object {
    @objc dynamic var imageName: String = ""
    @objc dynamic var imageEmotion: String = ""
    
    override static func primaryKey() -> String? {
        return "imageName"
    }
}
