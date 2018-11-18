//
//  CartViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 29/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

struct CartCellData {
    var restaurantName = ""
    var foodItems = [FoodItem]()
}

class CartViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var collectionViewData = [CartCellData]()
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        collectionView.register(CartCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(FinalPriceView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "finalPriceView")
        title = "Your Cart"
        
        getDataForItemsInCart()
    }
    
    func getDataForItemsInCart(_ indexPath: IndexPath? = nil, _ operation: String? = nil) {
        print("before", collectionViewData)
        collectionViewData = []
        var items = [String : [FoodItem]]()
        if let cart = appDelegate.cartItems[appDelegate.currentFoodCourt.id], cart.count > 0 {
            for (id, count) in cart {
//                print(id, count)
                if let item = appDelegate.items[id] {
                    if let _ = items[item.restaurantName] {
                        item.count = Int(count)!
                        print(item.name)
                        items[item.restaurantName]?.append(item)
                    } else {
                        item.count = Int(count)!
                        items[item.restaurantName] = [item]
                    }
                }
            }
        }
//        print(items)
        for (name, itemList) in items {
            var data = CartCellData()
            data.restaurantName = name
            data.foodItems = itemList
            collectionViewData.append(data)
        }
        print("after", collectionViewData)
        if let indexPath = indexPath {
            if let operation = operation, operation == "delete" {
                collectionView.deleteItems(at: [IndexPath(item: indexPath.item, section: indexPath.section)])
            }
            collectionView.reloadSections(IndexSet(integer: indexPath.section))
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionViewData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData[section].foodItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CartCollectionViewCell
        let item = collectionViewData[indexPath.section].foodItems[indexPath.item]
        cell.itemName.text = item.name
        cell.amountLabel.text = "$\(item.cost)"
        cell.stepper.value = Double(item.count)
        cell.totalAmountLabel.text = "$\((item.cost * Double(item.count)).rounded(toPlaces: 2))"
        cell.stepper.tag = item.id
        cell.item = item
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! HeaderView
            view.imageView.image = UIImage(named: collectionViewData[indexPath.section].restaurantName)
            view.jointName.text = collectionViewData[indexPath.section].restaurantName
            return view
        case UICollectionView.elementKindSectionFooter:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "finalPriceView", for: indexPath) as! FinalPriceView
            view.checkoutButton.addTarget(self, action: #selector(placeOrder), for: .touchUpInside)
            
            var subtotal = 0.0
            for data in collectionViewData {
                for item in data.foodItems {
                    subtotal += (item.cost * Double(item.count))
                }
            }
            view.subtotalAmountLabel.text = "$\(subtotal.rounded(toPlaces: 2))"
            view.taxesAndChargesAmountLabel.text = "$\((subtotal * 0.13).rounded(toPlaces: 2))"
            view.grandTotalAmountLabel.text = "$\((subtotal * 1.13).rounded(toPlaces: 2))"
            
            return view
        default:
            return UICollectionReusableView(frame: CGRect.zero)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == collectionView.numberOfSections - 1 {
            return CGSize(width: collectionView.frame.width, height: 152)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func placeOrder() {
        let params = [
            Client.Keys.Email: appDelegate.currentUser!.emailID,
            Client.Keys.Token: appDelegate.currentUser!.accessToken,
            Client.Keys.OrderDetails: appDelegate.cartItems[appDelegate.currentFoodCourt.id]!
        ] as [String : AnyObject]
        
        self.view.makeToastActivity(.center)
        Client.sharedInstance.placeOrder(params) { (category, success, message) in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                
            }
        }
        let vc = OrderConfirmationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
