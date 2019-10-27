//
//  EasySwitchDelegate.swift
//  Webtics
//
//  Created by Mudith Chathuranga on 10/22/18.
//  Copyright © 2018 Webnatics. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol EasySwitchDelegate: NSObjectProtocol {
    
    @objc func easySwitch(isOn: Bool)
    
}
