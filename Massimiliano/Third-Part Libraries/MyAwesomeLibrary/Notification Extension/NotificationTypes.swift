//
//  NotificationTypes.swift
//  EventApp
//
//  Created by Mudith Chathuranga on 10/10/18.
//  Copyright © 2018 Webnatics. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didChangeActiveCard = Notification.Name("ChangedActiveCard")
    static let didMenuStatusChanged = Notification.Name("MenuClosed")
    static let didQuestionsLoaded = Notification.Name("QuestionsLoaded")
}

/*

// Post Notification :-

NotificationCenter.default.post(name: .didChangeActiveCard, object: nil, userInfo: ["activeView": self.foucusedIndex])



// Subscribe Notification :-

NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: .didChangeActiveCard, object: nil)

@objc func methodOfReceivedNotification(notification: Notification){
    guard let userInfo = notification.userInfo, let activeView  = userInfo["activeView"] as? Int else {
        print("No userInfo found in notification")
        return
    }
    if self.indexPathRow == activeView {
        self.makeViewHeightUp()
    } else {
        self.makeViewHeightDown()
    }
}

}


// Unsubscribe Notification :-

NotificationCenter.default.removeObserver(self)
NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
 */
