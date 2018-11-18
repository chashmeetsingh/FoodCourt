//
//  ViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import MMDrawerController
import MaterialComponents.MaterialButtons
import Foundation

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var facebookButton: LeftAlignedIconButton!
    @IBOutlet weak var googleButton: LeftAlignedIconButton!
    @IBOutlet weak var guestButton: LeftAlignedIconButton!
    @IBOutlet weak var existingUserButton: LeftAlignedIconButton!
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleButton.inkColor = UIColor(hex: "#E0E0E0")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults.standard
        print(defaults.dictionary(forKey: "currentUser") ?? "")
        if let currentUser = defaults.dictionary(forKey: "currentUser") as? [String : AnyObject] {
            appDelegate.currentUser = User(dictionary: currentUser)
            self.completeLogin()
        }
    }
    
    func completeLogin() {
        self.view.makeToastActivity(.center)
        let mainController = ClientHomeViewController()
        let nvc = UINavigationController(rootViewController: mainController)
        let drawerViewController = DrawerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        self.appDelegate.centerContainer = MMDrawerController(center: nvc, leftDrawerViewController: drawerViewController)
        self.appDelegate.centerContainer!.openDrawerGestureModeMask = .panningCenterView
        self.appDelegate.centerContainer!.closeDrawerGestureModeMask = .panningCenterView
        self.appDelegate.centerContainer?.setDrawerVisualStateBlock(MMDrawerVisualState.slideAndScaleBlock())
        
        self.present(appDelegate.centerContainer!, animated: true, completion: nil)
        self.view.hideToastActivity()
    }

    @IBAction func button1Tapped(_ sender: Any) {
        
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func continueAsGuestButtonTapped(_ sender: Any) {
        let mainController = ClientHomeViewController()
        let nvc = UINavigationController(rootViewController: mainController)
        let drawerViewController = DrawerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        appDelegate.centerContainer = MMDrawerController(center: nvc, leftDrawerViewController: drawerViewController)
        appDelegate.centerContainer!.openDrawerGestureModeMask = .panningCenterView
        appDelegate.centerContainer!.closeDrawerGestureModeMask = .panningCenterView
        appDelegate.centerContainer?.setDrawerVisualStateBlock(MMDrawerVisualState.slideAndScaleBlock())
        
        self.show(appDelegate.centerContainer!, sender: self)
    }
    
    @IBAction func loginAsUserButtonTapped(_ sender: Any) {
        let vc = LoginViewController()
        vc.modalTransitionStyle = .flipHorizontal
        vc.authController = self
        let nvc = UINavigationController(rootViewController: vc)
        self.present(nvc, animated: true, completion: nil)
    }
    
}

