//
//  UILabelExtension.swift
//  MyAwesomeLibrary
//
//  Created by Mudith Chathuranga on 1/15/19.
//  Copyright © 2019 Chathuranga. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func numberOfLines() -> Int {
        let textSize = CGSize(width: self.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(self.font.lineHeight))
        let lineCount = rHeight/charSize
        return lineCount
    }
    
}
