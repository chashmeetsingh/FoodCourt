//
//  OrdersViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 31/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import MMDrawerController

class OrdersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var drawerOpen = false
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Orders"
        collectionView.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openDrawer))
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    @objc func openDrawer() {
        if drawerOpen {
            appDelegate.centerContainer?.closeDrawer(animated: true, completion: nil)
        } else {
            appDelegate.centerContainer?.open(.left, animated: true, completion: nil)
        }
        drawerOpen = !drawerOpen
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 4, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }

}
