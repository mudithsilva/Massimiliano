//
//  EasySwitch.swift
//  Webtics
//
//  Created by Mudith Chathuranga on 10/22/18.
//  Copyright © 2018 Webnatics. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class EasySwitch: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var switchBackView: UIView!
    @IBOutlet var middleOnSwitchView: UIView!
    @IBOutlet var middleOffSwitchView: UIView!
    @IBOutlet weak var middleOnSwitchWidth: NSLayoutConstraint!
    @IBOutlet weak var middleOffSwitchWidth: NSLayoutConstraint!
    
    @IBOutlet weak var middleOnSwitchTitle: UILabel!
    @IBOutlet weak var middleOffSwitchTitle: UILabel!
    
    weak open var delegate:EasySwitchDelegate!
    
    @IBInspectable public var okColor: UIColor = UIColor.green {
        didSet {
            self.switchOkColor = self.okColor
        }
    }
    
    @IBInspectable public var cancelColor: UIColor = UIColor.red {
        didSet {
            self.switchCancelColor = self.cancelColor
        }
    }
    
    @IBInspectable public var outerBorderColor: UIColor = UIColor.gray {
        didSet {
            self.viewOuterBorderColor = self.outerBorderColor
        }
    }
    
    @IBInspectable public var outerCornerRadius: CGFloat = 0 {
        didSet {
            self.viewOuterCornerRadius = self.outerCornerRadius
        }
    }
    
    @IBInspectable public var innerCornerRadius: CGFloat = 0 {
        didSet {
            self.viewInnerCornerRadius = self.innerCornerRadius
        }
    }
    
    @IBInspectable public var outerBorderWidth: CGFloat = 0 {
        didSet {
            self.viewOuterBoarderWidth = self.outerBorderWidth
        }
    }
    
    @IBInspectable public var isOn: Bool = true {
        didSet {
            self.isSwitchOn = self.isOn
        }
    }
    
    @IBInspectable public var onTitle: String = "" {
        didSet {
            self.viewOnTitle = self.onTitle
        }
    }
    
    @IBInspectable public var offTitle: String = "" {
        didSet {
            self.viewOffTitle = self.offTitle
        }
    }
    
    
    
    private var switchOkColor: UIColor = UIColor(red: 39.0/255.0, green: 174.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    private var switchCancelColor: UIColor = UIColor(red: 237.0/255.0, green: 87.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    private var viewOuterBorderColor: UIColor = UIColor(red: 237.0/255.0, green: 87.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    
    private var isSwitchOn: Bool = true
    private var viewOuterCornerRadius: CGFloat = 0
    private var viewInnerCornerRadius: CGFloat = 0
    private var viewOuterBoarderWidth: CGFloat = 0
    
    private var viewOnTitle: String = ""
    private var viewOffTitle: String = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        Bundle.main.loadNibNamed("EasySwitch", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.configViews()
    }
    
    private func configViews() {
        self.switchBackView.layer.cornerRadius = self.viewOuterCornerRadius
        self.switchBackView.layer.borderWidth = self.viewOuterBoarderWidth
        self.switchBackView.layer.borderColor = self.viewOuterBorderColor.cgColor
        
        self.middleOnSwitchView.layer.cornerRadius = self.viewInnerCornerRadius
        self.middleOffSwitchView.layer.cornerRadius = self.viewInnerCornerRadius
        
        self.middleOnSwitchWidth.constant = self.switchBackView.frame.size.width / 2
        self.middleOffSwitchWidth.constant = self.switchBackView.frame.size.width / 2
        
        self.middleOnSwitchView.backgroundColor = self.switchOkColor
        self.middleOffSwitchView.backgroundColor = self.switchCancelColor
        
        self.middleOnSwitchTitle.text = self.viewOnTitle
        self.middleOffSwitchTitle.text = self.viewOffTitle
        
        self.changeSwitchState()
        
    }
    
    func changeSwitchState() {
        if self.isSwitchOn {
            self.middleOnSwitchView.alpha = 1.0
            self.middleOffSwitchView.alpha = 0
        } else {
            self.middleOffSwitchView.alpha = 1.0
            self.middleOnSwitchView.alpha = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    
    @IBAction func clickedSwitch(_ sender: Any) {
        if self.isSwitchOn {
            self.isSwitchOn = false
        } else {
            self.isSwitchOn = true
        }
        self.changeSwitchState()
        self.delegate.easySwitch(isOn: self.isSwitchOn)
    }
    
    
}
