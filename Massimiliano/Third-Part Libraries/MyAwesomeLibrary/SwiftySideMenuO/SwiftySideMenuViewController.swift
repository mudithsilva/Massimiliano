//
//  SwiftySideMenuViewController.swift
//  SwiftySideMenu
//
//  Created by Mudith Chathuranga on 5/30/17.
//  Copyright © 2017 Mudith Chathuranga. All rights reserved.
//

import UIKit

open class SwiftySideMenuViewController: UIViewController {
    
    weak open var dataSource:SwiftySideMenuDataSource?
    
    public let mainView = UIView()
    private let sideView = UIView()
    private let dismissView = UIView()
    private let menuButtonImageView: UIImageView = UIImageView()
    
    private enum Direction {
        case Up
        case Down
        case Left
        case Right
    }
    
    private var buttonImageName: String = "menuButton"
    private let navigationBarHeight: CGFloat = 60.0
    private let menuClicableButtonHeight: CGFloat = 37.0
    private let menuClicableButtonWidth: CGFloat = 57.0
    private var sideViewWidth: CGFloat!
    private var childVC: [SwiftySideMenuChildViewControllers] = []
    private var isLoadedConterollers: Bool = false
    
    private var selectedIndexPathRow: Int = 0
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.loadDismissView()
        self.loadSideView()
        self.loadMainView()
        
        self.view.bringSubviewToFront(self.sideView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        if !isLoadedConterollers {
            self.isLoadedConterollers = true
            self.childVC = self.dataSource!.menuNavigationTabs(self.sideView)
            SwiftySideMenuInfo.shared.childVC = self.childVC
            let storyboard = UIStoryboard(name: (self.childVC.first?.storyboardName)!, bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: (self.childVC.first?.viewControllerIdentifier!)!)
            addChild(controller)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(controller.view)
        
            NSLayoutConstraint.activate([
                controller.view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                controller.view.topAnchor.constraint(equalTo: mainView.topAnchor),
                controller.view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
            ])
            controller.didMove(toParent: self)
            
            self.changeTableViewAttributes()
        }
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: - Mange Device Orientation
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        self.sideView.alpha = 0
        
        if !SwiftySideMenuHelper.isMenuClosed {
            self.menuClose(isUserForceClose: true)
        }
        
        self.sideView.frame.size.width = size.width * 8/10
        self.sideView.frame.size.height = size.height
        SwiftySideMenuHelper.menuWidth = size.width * 8/10
        self.sideView.center.x = -size.height / 2
        
        let backGroundButtonView = self.dismissView.subviews.filter{$0 is UIButton}.first!
        backGroundButtonView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.sideView.alpha = 1
                self.sideView.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
        })
        
    }
    
    func setControllerDefaultValues() {
        self.sideViewWidth = self.view.frame.size.width * 8/10
        
    }
    
    func changeTableViewAttributes() {
        if let customView = self.dataSource?.menuNavigationTabs(subviewFor: self.sideView) {
            self.loadSideCustomView(customeView: customView)
        }
    }
    
    private func loadMainView() {
        //Add container view
        mainView.backgroundColor = UIColor.yellow // Add background color
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ])
    }
    
    private func loadSideView() {
        //Add container view
        sideView.backgroundColor = UIColor.white // Add background color
        sideView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(sideView)
        self.sideView.clipsToBounds = true
        self.sideView.frame.size.width = self.view.frame.size.width * 8/10
        self.sideView.frame.size.height = self.view.frame.size.height
        SwiftySideMenuHelper.menuWidth = self.view.frame.size.width * 8/10
        self.sideView.center.x = -self.view.frame.size.width / 2
        
        let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(guestureStateRecogniser(_:)))
        self.sideView.addGestureRecognizer(panGuesture)
        
    }
    
    private func loadSideCustomView(customeView: UIView) {
        //Add container view
        customeView.translatesAutoresizingMaskIntoConstraints = false
        sideView.addSubview(customeView)
        self.sideView.clipsToBounds = true
        NSLayoutConstraint.activate([
            customeView.leadingAnchor.constraint(equalTo: sideView.leadingAnchor, constant: 0),
            customeView.trailingAnchor.constraint(equalTo: sideView.trailingAnchor, constant: 0),
            customeView.topAnchor.constraint(equalTo: sideView.topAnchor, constant: 0),
            customeView.bottomAnchor.constraint(equalTo: sideView.bottomAnchor, constant: 0),
            ])
    }
    
    private func loadDismissView() {
        //Add container view
        dismissView.backgroundColor = UIColor.clear // Add background color
        dismissView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dismissView)
        dismissView.alpha = 0.0
        dismissView.clipsToBounds = true
        NSLayoutConstraint.activate([
            dismissView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            dismissView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            dismissView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            dismissView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ])
        
        let menueButton = UIButton()
        menueButton.clipsToBounds = true
        menueButton.backgroundColor = UIColor.clear
        let podBundle = Bundle(for: SwiftySideMenuImageView.self)
        menueButton.setBackgroundImage(UIImage(named: "dismissViewOverlay", in: podBundle, compatibleWith: nil), for: UIControl.State.normal)
        menueButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        menueButton.addTarget(self, action:#selector(self.menuClose), for: .touchUpInside)
        self.dismissView.addSubview(menueButton)
        
        self.view.sendSubviewToBack(self.dismissView)
    }
    
    private func calculateProgress(translationInView:CGPoint, viewBounds:CGRect, direction:Direction) -> CGFloat {
        let pointOnAxis:CGFloat
        let axisLength:CGFloat
        switch direction {
        case .Up, .Down:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
        case .Left, .Right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis:Float
        let positiveMovementOnAxisPercent:Float
        switch direction {
        case .Right, .Down: // positive
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)
        case .Up, .Left: // negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }
    
    func mapGestureStateToInteractor(gestureState:UIGestureRecognizer.State, progress:CGFloat, velocity: CGFloat, triggerFunc: () -> Void) {
        switch gestureState {
        case .began:
            triggerFunc()
        case .changed:
            self.sideView.center.x = self.sideView.frame.size.width / 2 - ((self.view.frame.size.width) * progress)
            self.dismissView.alpha = 1.0 - (1.0 * progress)
            SwiftySideMenuHelper.currentMenuWidth = (self.sideView.frame.size.width) * progress
        case .ended:
            if velocity < CGFloat(-1000.00) {
                self.menuClose(isUserForceClose: true)
            } else {
                if SwiftySideMenuHelper.shouldCloseMenu() {
                    self.menuClose(isUserForceClose: false)
                } else {
                    self.menuOpen()
                }
            }
        default:
            break
        }
    }
    
    @objc private func guestureStateRecogniser(_ sender: UIPanGestureRecognizer) {
        if !SwiftySideMenuHelper.isMenuClosed {
            let translation = sender.translation(in: view)
            let progress = self.calculateProgress(
                translationInView: translation,
                viewBounds: view.bounds,
                direction: .Left
            )
            self.mapGestureStateToInteractor(
                gestureState: sender.state,
                progress: progress,
                velocity: sender.velocity(in: view).x) {
                    //                    print(self.sideView.frame.origin.x)
            }
        }
    }
    
    func showClickedTab(selectedIndex: Int) {
        
        if self.selectedIndexPathRow != selectedIndex {
            self.selectedIndexPathRow = selectedIndex
            let previousView: UIView! = self.mainView.subviews.first
            
            let storyboard = UIStoryboard(name: (self.childVC[selectedIndex].storyboardName)!, bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: self.childVC[selectedIndex].viewControllerIdentifier!)
            addChild(controller)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview(controller.view)
            
            NSLayoutConstraint.activate([
                controller.view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
                controller.view.topAnchor.constraint(equalTo: mainView.topAnchor),
                controller.view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
                ])
            controller.didMove(toParent: self)
            
            if previousView != nil {
                previousView.removeFromSuperview()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.menuClose(isUserForceClose: false)
        })
    }
    
    func menuButtonClicked() {
        self.view.insertSubview(self.dismissView, belowSubview: self.sideView)
        SwiftySideMenuHelper.isMenuClosed = false
        UIView.animate(withDuration: 0.5) {
            self.sideView.center.x = +self.sideView.frame.size.width / 2
            self.dismissView.alpha = 1.0
            self.view.layoutIfNeeded()
        }
    }
    
    func menuButtonClosedClicked() {
        UIView.animate(withDuration: 0.5, animations: {
            self.sideView.center.x = -self.sideView.frame.size.width / 2
            self.view.layoutIfNeeded()
            self.dismissView.alpha = 0.0
        }, completion: { completed in
            self.view.sendSubviewToBack(self.dismissView)
            SwiftySideMenuHelper.isMenuClosed = true
        })
    }
    
    func menuOpen() {
        UIView.animate(withDuration: 0.3) {
            self.sideView.center.x = +self.sideView.frame.size.width / 2
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func menuClose(isUserForceClose: Bool) {
        if isUserForceClose {
            UIView.animate(withDuration: 0.2, animations: {
                self.sideView.center.x = -self.sideView.frame.size.width / 2
                self.view.layoutIfNeeded()
                self.dismissView.alpha = 0.0
            }, completion: { completed in
                self.view.sendSubviewToBack(self.dismissView)
                SwiftySideMenuHelper.isMenuClosed = true
                
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.sideView.center.x = -self.sideView.frame.size.width / 2
                self.view.layoutIfNeeded()
                self.dismissView.alpha = 0.0
            }, completion: { completed in
                self.view.sendSubviewToBack(self.dismissView)
                SwiftySideMenuHelper.isMenuClosed = true
                
            })
        }
    }
}
