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
    
    let items = ["Dashboard", "Profile", "Your Orders", "Logout"]
    
    var appDelegate: AppDelegate {
        get {
           return UIApplication.shared.delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .black
        collectionView.register(DrawerCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(DrawerHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DrawerCell
        cell.menuItemLabel.text = items[indexPath.item]
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
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! DrawerHeaderCell
            view.backgroundColor = .gray
            
            if let user = appDelegate.currentUser {
                view.label.text = user.name
            } else {
                view.label.text = "Guest User"
            }
            
            return view
        default:
            return UICollectionReusableView(frame: CGRect.zero)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showDashboard()
        case 1:
            showProfile()
        case 2:
            showOrders()
        case 3:
            logoutUser()
        default:
            break
        }
    }
    
    func showDashboard() {
        if let _ = navigationController?.topViewController as? ClientHomeViewController {
            closeDrawer()
        } else {
            let nvc = appDelegate.centerContainer?.centerViewController as! UINavigationController
            let homeViewController = ClientHomeViewController()
            nvc.pushViewController(homeViewController, animated: true)
            appDelegate.centerContainer?.closeDrawer(animated: true, completion: nil)
        }
    }
    
    func showProfile() {
        if let _ = navigationController?.topViewController as? ProfileViewController {
            closeDrawer()
        } else {
            let nvc = appDelegate.centerContainer?.centerViewController as! UINavigationController
            let profileViewController = ProfileViewController()
            nvc.pushViewController(profileViewController, animated: true)
            appDelegate.centerContainer?.closeDrawer(animated: true, completion: nil)
        }
    }
    
    func closeDrawer() {
        appDelegate.centerContainer?.closeDrawer(animated: true, completion: nil)
    }
    
    func logoutUser() {
        
        if let user = appDelegate.currentUser {
            let params = [
                Client.Keys.Email: user.emailID,
                Client.Keys.Token: user.accessToken
            ]
            
            Client.sharedInstance.logoutUser(params as [String : AnyObject]) { (_, success, error) in
                DispatchQueue.main.async {
                    if success {
                        self.appDelegate.centerContainer?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        } else {
            self.appDelegate.centerContainer?.dismiss(animated: true, completion: nil)
        }
        
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
