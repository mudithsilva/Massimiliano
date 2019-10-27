//
//  DoubleExtension.swift
//  PharmEasy
//
//  Created by Mudith Chathuranga on 11/2/18.
//  Copyright © 2018 Ceffectz. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func roundedToCurrency() -> String {
        return String(format: "%.2f", self)
    }
    
     func truncate(places : Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
