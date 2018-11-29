//
//  ClientOrderDetailViewController.swift
//  Food Court
//
//  Created by Chashmeet on 29/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

struct OrderDetailCellData {
    var restaurantName = ""
    var orderItems = [OrderItem]()
}

class ClientOrderDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var collectionViewData = [OrderDetailCellData]()
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    var data = [String : [OrderItem]]()
    
    var order: Order! {
        didSet {
            for item in order.orderItems {
                if data["\(item.restaurantName)"] == nil {
                    data["\(item.restaurantName)"] = []
                }
                data["\(item.restaurantName)"]?.append(item)
            }
            for (key, value) in data {
                var cartCell = OrderDetailCellData()
                cartCell.restaurantName = key
                cartCell.orderItems = value
                collectionViewData.append(cartCell)
            }
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        collectionView.register(OrderDetailViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(FinalPriceView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "finalPriceViewDetail")
        title = "Order Details"
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionViewData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData[section].orderItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderDetailViewCell
        let item = collectionViewData[indexPath.section].orderItems[indexPath.item]
        cell.item = item
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
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "finalPriceViewDetail", for: indexPath) as! FinalPriceView
            
            view.checkoutButton.isHidden = true
            
            var subtotal = 0.0
            for data in collectionViewData {
                for item in data.orderItems {
                    subtotal += (item.itemCost * Double(item.quantity))
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
            return CGSize(width: collectionView.frame.width, height: 100)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
