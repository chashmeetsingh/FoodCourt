//
//  DrawerViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 31/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import MMDrawerController

class DrawerViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var appDelegate: AppDelegate {
        get {
           return UIApplication.shared.delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .black
        collectionView.register(DrawerCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DrawerCell
//        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath)
            view.backgroundColor = .blue
            return view
        default:
            return UICollectionReusableView(frame: CGRect.zero)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0...5:
            showOrders()
        default:
            break
        }
    }
    
    func closeDrawer() {
        appDelegate.centerContainer?.closeDrawer(animated: true, completion: nil)
    }
    
    func showOrders() {
        if let _ = navigationController?.topViewController as? OrdersViewController {
            closeDrawer()
        } else {
            let nvc = appDelegate.centerContainer?.centerViewController as! UINavigationController
            let orderController = OrdersViewController(collectionViewLayout: UICollectionViewFlowLayout())
            nvc.pushViewController(orderController, animated: true)
            appDelegate.centerContainer?.closeDrawer(animated: true, completion: nil)
        }
    }

}
