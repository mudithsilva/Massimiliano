//
//  MyAwesomeTextView.swift
//  PharmEasy
//
//  Created by Mudith Chathuranga on 11/26/18.
//  Copyright © 2018 Ceffectz. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class MyAwesomeTextView: UITextView {
    
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            self.addShadow()
        }
    }
    
    @IBInspectable public var offSetWidth: Double = -1.0 {
        didSet {
            self.addShadow()
        }
    }
    
    @IBInspectable public var offSetHeight: Double = 4.0 {
        didSet {
            self.addShadow()
        }
    }
    
    @IBInspectable public var shadowOpacity: Double = 0.5 {
        didSet {
            self.addShadow()
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 4.0 {
        didSet {
            self.addShadow()
        }
    }
    
    @IBInspectable public var addShaddow: Bool = false {
        didSet {
            self.addShadow()
        }
    }
    
    @IBInspectable public var leftViewWidth: CGFloat = 0 {
        didSet {
            self.addLeftViewBox()
        }
    }
    
    @IBInspectable public var rightViewWidth: CGFloat = 0 {
        didSet {
            self.addRightViewBox()
        }
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: CGRect.zero, textContainer: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func addShadow() {
        if addShaddow {
            self.layer.masksToBounds = false
            self.layer.shadowColor = self.shadowColor.cgColor
            self.layer.shadowOpacity = Float(self.shadowOpacity)
            self.layer.shadowOffset = CGSize(width: self.offSetWidth, height: self.offSetHeight)
            self.layer.shadowRadius = self.shadowRadius
        } else {
            self.layer.shadowOpacity = 0
        }
    }
    
    public func addLeftViewBox() {
        self.textContainerInset.left = self.leftViewWidth
    }
    
    public func addRightViewBox() {
        self.textContainerInset.right = self.rightViewWidth
    }
    
    //    Int
    //    CGFloat
    //    Double
    //    String
    //    Bool
    //    CGPoint
    //    CGSize
    //    CGRect
    //    UIColor
    //    UIImage
}

