//
//  SwiftySideMenuImageView.swift
//  navigationTest
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Mudith Chathuranga. All rights reserved.
//

import UIKit

public class SwiftySideMenuImageView: UIView {
    
    @IBOutlet weak var menuButtonImage: UIImageView!
    @IBAction func openMenu(_ sender: UIButton) {
        if SwiftySideMenuHelper.isMenuClosed {
            SwiftySideMenuInfo.shared.swiftySideMenu.menuButtonClicked()
        } else {
            SwiftySideMenuInfo.shared.swiftySideMenu.menuButtonClosedClicked()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didMenuStatusChanged, object: nil)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        NotificationCenter.default.addObserver(self, selector: #selector(self.menuNotification(notification:)), name: .didMenuStatusChanged, object: nil)
        let podBundle = Bundle(for: SwiftySideMenuImageView.self)
        self.menuButtonImage.image = UIImage(named: "menuButton", in: podBundle, compatibleWith: nil)
        self.backgroundColor = UIColor.clear
    }
    
    public class func getMenuImageView() -> SwiftySideMenuImageView {
        let cellNib = UINib(nibName: "SwiftySideMenuImageView", bundle: Bundle(for: SwiftySideMenuImageView.self))
        return cellNib.instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
    }
    
    public class func addMenuImageView(addMenuViewTo parentView: UIView) {
        let cellNib = UINib(nibName: "SwiftySideMenuImageView", bundle: Bundle(for: SwiftySideMenuImageView.self))
        let childView = cellNib.instantiate(withOwner: nil, options: nil)[0] as! SwiftySideMenuImageView
        childView.frame = parentView.bounds
        parentView.addSubview(childView)
    }
    
    @objc func menuNotification(notification: Notification) {
        let podBundle = Bundle(for: SwiftySideMenuImageView.self)
        guard let userInfo = notification.userInfo, let isMenuClosed = userInfo["isMenuClosed"] as? Bool else {
            print("No userInfo found in notification")
            return
        }
        if isMenuClosed {
            self.menuButtonImage.image = UIImage(named: "menuButton", in: podBundle, compatibleWith: nil)
        } else {
            self.menuButtonImage.image = UIImage(named: "menuButton", in: podBundle, compatibleWith: nil)
        }
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
