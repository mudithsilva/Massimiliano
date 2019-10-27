//
//  AlertController.swift
//  Event Reg
//
//  Created by Mudith Chathuranga on 9/10/18.
//  Copyright © 2018 Webnatics. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    
    var viewController: UIViewController!
    var alert: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    deinit {
        //        print("deinit \(viewController)")
    }
    
    
    func showAlert(title:String, message: String, buttons: [UIAlertAction]) {
        // create the alert
        self.alert.title = title
        self.alert.message = message
        
        // add an action (button)
        if buttons.count == 0 {
            self.alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        } else {
            for i in 0...buttons.count-1 {
                self.alert.addAction(buttons[i])
            }
        }
        self.viewController.present(alert, animated: true, completion: nil)
    }
    
    func showOneAlert(title:String, message: String, button: UIAlertAction) {
        // create the alert
        self.alert.title = title
        self.alert.message = message
        
        self.alert.addAction(button)
        
        // show the alert
        self.viewController.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlerts(connectionError status: ConnectionError, forViewController viewController: UIViewController, errorTitle: String) {
        
        switch status {
        case .conenction, .server:
            
            let retryAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in })
            let alert = AlertController(viewController: viewController)
            alert.showOneAlert(title: errorTitle, message: status.rawValue, button: retryAction)
            
        case .sessionTimeOut:
            
            let retryAction: UIAlertAction = UIAlertAction(title: "Sign In", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                AppData.removeAll()
                //                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //                let controller = storyboard.instantiateViewController(withIdentifier: "LanuchViewController")
                //                viewController.present(controller, animated: true, completion: nil)
            })
            let alert = AlertController(viewController: viewController)
            alert.showOneAlert(title: errorTitle, message: status.rawValue, button: retryAction)
            
        
        case .serverTimeout:
            
            let retryAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in })
            let alert = AlertController(viewController: viewController)
            alert.showOneAlert(title: errorTitle, message: status.rawValue, button: retryAction)
            
        default:
            
            break
        }
        
    }
}

enum ConnectionError:String {
    case tokenRefresh = "Session Time out. Please try again."
    case conenction = "Connection Error. Please try again later."
    case server = "Server Error. Please try again later."
    case sessionTimeOut = "Session Time out. Please sign in again."
    case serverTimeout = "Server Time out. Please try again later"
    case none = "Completed!"
}

