//
//  StringExtension.swift
//  PharmEasy
//
//  Created by Mudith Chathuranga on 10/23/18.
//  Copyright © 2018 Ceffectz. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    enum LocalizedCountry: String {
        case English = "en"
        case Sinhala = "si"
        case Tamil = "ta-LK"
    }
    
    func localized(lang: LocalizedCountry) -> String {
        
        let path = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "**\(self)**", comment: "")
    }
    
    /*
     "<key>" = "<value>"; on localise file
     
     "data_loaded".localized(lang: .English) // Data Loaded! if available
     "hello_world".localized(lang: .English) // **hello_world** key load if not available
 
     */
}



extension String {
    
    func strikeThrough() -> NSAttributedString {
        let strickThroughString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        return strickThroughString
    }
    
    func getTextWidth(fontName: String, fontSize: CGFloat, marigine: CGFloat) -> CGFloat {
        let font: UIFont = UIFont(name: fontName, size: fontSize)!
        let attributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attributes).width + marigine
    }
    
    func getTextHeight(fontName: String, fontSize: CGFloat, marigine: CGFloat) -> CGFloat {
        let font: UIFont = UIFont(name: fontName, size: fontSize)!
        let attributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attributes).height + marigine
    }
    
    func getStringLabelHeight(fontName: String, fontSize: CGFloat, marigine: CGFloat, maxWidth: CGFloat) -> CGFloat {
        let maxLabelWidth:CGFloat = maxWidth
        let label = UILabel()
        label.numberOfLines = 0
        let addressFont = [NSAttributedString.Key.font: UIFont(name: fontName, size: fontSize)!]
        let addr = self
        label.attributedText = NSMutableAttributedString(string: addr , attributes: addressFont )
        let neededSize:CGSize = label.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        return neededSize.height + marigine
    }
    
    func localToUTC(date:String, fromFormat: String, toFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    func UTCToLocal(date:String) -> String {
        
        let fromFormat: String = "HH:mm:ss ,yyyy-MM-dd"
        let toFormat: String = "h:mm a, MMM dd yyy"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }
    
}
