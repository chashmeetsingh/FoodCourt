//
//  ViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import MMDrawerController

class AuthenticationViewController: UIViewController {
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func button1Tapped(_ sender: Any) {
        let mainController = ClientHomeViewController()
        let nvc = UINavigationController(rootViewController: mainController)
        let drawerViewController = DrawerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        appDelegate.centerContainer = MMDrawerController(center: nvc, leftDrawerViewController: drawerViewController)
        appDelegate.centerContainer!.openDrawerGestureModeMask = .panningCenterView
        appDelegate.centerContainer!.closeDrawerGestureModeMask = .panningCenterView
        appDelegate.centerContainer?.setDrawerVisualStateBlock(MMDrawerVisualState.slideAndScaleBlock())
        
        self.show(appDelegate.centerContainer!, sender: self)
    }
    
    @IBAction func button2Tapped(_ sender: Any) {
        
    }
    
}

