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
    
    var activeOrders = [Order]()
    var completedOrders = [Order]()
    
    var orders: [Order]! {
        get {
            return activeOrders + completedOrders
        }
    }
    
    let noOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "No orders yet."
        label.textColor = .gray
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Orders"
        collectionView.backgroundColor = .black//UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openDrawer))
        
        collectionView.register(ClientOrderCell.self, forCellWithReuseIdentifier: "cell")
        
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if appDelegate.currentUser == nil {
//            noOrderLabel.isHidden = false
//        } else {
            getOrders()
//        }
    }
    
    func getOrders() {
        self.view.makeToastActivity(.center)
        
        let params = [
            Client.Keys.Email: "jalaj@yopmail.com",//appDelegate.currentUser!.emailID,
            Client.Keys.Token: "yololo"//appDelegate.currentUser!.accessToken
        ]
        
        Client.sharedInstance.getOrders(params as [String : AnyObject]) { (activeOrders, completedOrders, _, success, message) in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.activeOrders = activeOrders!
                self.completedOrders = completedOrders!
                self.collectionView.reloadData()
                if self.activeOrders.count + self.completedOrders.count > 0 {
                    self.noOrderLabel.isHidden = true
                } else {
                    self.noOrderLabel.isHidden = false
                }
            }
        }
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
        return orders.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ClientOrderCell
        let item = orders[indexPath.item]
        cell.foodCourtName.text = item.foodCourtName
        cell.orderNumberLabel.text = "#\(item.id)"
        cell.orderStatusButton.tag = indexPath.item
        cell.orderStatusButton.addTarget(self, action: #selector(orderStatusView(_:)), for: .touchUpInside)
        cell.orderDetailsButton.addTarget(self, action: #selector(orderDetails(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    @objc func orderStatusView(_ sender: Any?) {
        if let cell = sender as? UIButton {
            let vc = OrderConfirmationViewController()
            vc.order = orders[cell.tag]
            vc.yourOrdersView = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func orderDetails(_ sender: Any?) {
        if let cell = sender as? UIButton {
            let vc = OrderDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.order = orders[cell.tag]
            vc.yourOrdersView = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
