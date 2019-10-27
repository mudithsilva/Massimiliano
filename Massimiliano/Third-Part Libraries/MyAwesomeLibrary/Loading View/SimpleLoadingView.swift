//
//  SimpleLoadingView.swift
//  EventApp
//
//  Created by Mudith Chathuranga on 10/10/18.
//  Copyright © 2018 Webnatics. All rights reserved.
//

import UIKit

class SimpleLoadingView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingInfoView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initiateView()
    }
    
    private func initiateView() {
        Bundle.main.loadNibNamed("SimpleLoadingView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.loadingInfoView.layer.cornerRadius = 6.0

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    func hidesLoadingView(parentView: UIViewController) {
        parentView.view.sendSubviewToBack(self)
        self.loadingView.alpha = 0.0
        self.activityIndicator.stopAnimating()
    }
    
    func showLoadingView(parentView: UIViewController) {
        parentView.view.bringSubviewToFront(self)
        self.loadingView.alpha = 1.0
        self.activityIndicator.startAnimating()
    }

}
