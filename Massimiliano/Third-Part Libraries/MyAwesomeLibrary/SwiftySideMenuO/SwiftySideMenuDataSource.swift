//
//  SwiftySideMenuDataSource.swift
//  SwiftySideMenu
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Mudith Chathuranga. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SwiftySideMenuDataSource: NSObjectProtocol {
    
    @objc func menuNavigationTabs(_ sideView: UIView) -> [SwiftySideMenuChildViewControllers]
    
    @objc func menuNavigationTabs(subviewFor sideMenu: UIView) -> UIView
    
}
