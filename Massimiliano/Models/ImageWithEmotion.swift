//
//  ImageWithEmotion.swift
//  Massimiliano
//
//  Created by Mudith Chathuranga on 11/2/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import Foundation
import UIKit

class ImageWithEmotion: Codable {
    
    var identifier: String
    var imageData: Data
    
    init(identifier: String, imageData: Data) {
        self.identifier = identifier
        self.imageData = imageData
    }
}
