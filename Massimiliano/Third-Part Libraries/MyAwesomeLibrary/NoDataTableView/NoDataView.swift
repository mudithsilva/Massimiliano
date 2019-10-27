//
//  NoDataView.swift
//
//  Created by Mudith Chathuranga on 1/23/18.
//  Copyright © 2018 Chathuranga. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    
    @IBOutlet weak var noDataIcons: UIImageView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    class func getNoDataView(iconName: String?, title: String) -> NoDataView {
        let noDataView = UINib(nibName: "NoDataView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NoDataView
        if iconName != nil {
            noDataView.noDataIcons.image = UIImage(named: iconName!)
        }
        noDataView.noDataLabel.text = title
        return noDataView
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
