//
//  SwiftySideMenuInfo.swift
//  event360-vendor-ios-app
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Suren Dias. All rights reserved.
//

import Foundation
import UIKit

public class SwiftySideMenuInfo {
    
    public static let shared = SwiftySideMenuInfo()
    
    private init() { }
    
    
    public var swiftySideMenu : SwiftySideMenuViewController!
    public var childVC : [SwiftySideMenuChildViewControllers]!
    public var mainView: UIView!
    private var selectedIndexPathRow: Int = 0
    
    open func openChildVC(viewName: String) {
        if let vcIndex = self.childVC.index(where: { $0.tabName == viewName }) {
            if self.selectedIndexPathRow != vcIndex {
                self.selectedIndexPathRow = vcIndex
                self.mainView = self.swiftySideMenu.mainView
                let previousView: UIView! = self.mainView.subviews.first
                
                let controller = self.swiftySideMenu.storyboard!.instantiateViewController(withIdentifier: self.childVC[vcIndex].viewControllerIdentifier!)
                swiftySideMenu.addChild(controller)
                controller.view.translatesAutoresizingMaskIntoConstraints = false
                mainView.addSubview(controller.view)
                
                NSLayoutConstraint.activate([
                    controller.view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                    controller.view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                    controller.view.topAnchor.constraint(equalTo: mainView.topAnchor),
                    controller.view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
                    ])
                controller.didMove(toParent: swiftySideMenu)
                
                if previousView != nil {
                    previousView.removeFromSuperview()
                }
            }
        } else {
            print("Invalid viewName:- \(viewName)")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.swiftySideMenu.menuClose(isUserForceClose: false)
        })
    }
}
