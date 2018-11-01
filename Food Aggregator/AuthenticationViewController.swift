//
//  ViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import KYDrawerController

class AuthenticationViewController: UIViewController {
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: Any) {
        let mainController = HomeViewController()
        let nvc = UINavigationController(rootViewController: mainController)
        let drawerViewController = DrawerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let drawerController = KYDrawerController(drawerDirection: .left, drawerWidth: self.view.bounds.width / 1.5)
        drawerController.mainViewController = nvc
        drawerController.drawerViewController = drawerViewController
        
        self.show(drawerController, sender: self)
    }
}

