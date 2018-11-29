//
//  OrderCell.swift
//  VendorFoodApp
//
//  Created by Chashmeet on 11/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

enum OrderType {
    case active
    case complete
}

class VendorOrderCell: BaseCollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var orderType: OrderType!
    var orders: [Order]! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var homeController: VendorHomeViewController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white//UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 8)
        
        collectionView.register(OrderItemCell.self, forCellWithReuseIdentifier: "orderItemCell")
//        collectionView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderItemCell", for: indexPath) as! OrderItemCell
        cell.backgroundColor = .white
        cell.order = orders[indexPath.item]
        cell.layer.cornerRadius = 20
        
//        cell.layer.borderColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0).cgColor
//        cell.layer.borderWidth = 7
        cell.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        var items = ""
        for item in orders[indexPath.item].orderItems {
            items += "\(item.quantity) X \(item.name), "
        }
        items.removeLast()
        items.removeLast()
        cell.itemsLabel.text = items
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var items = ""
        for item in orders[indexPath.item].orderItems {
            items += "\(item.quantity) X \(item.name), "
        }
        items.removeLast()
        items.removeLast()
        
        let size = CGSize(width: frame.width - 16 - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: items).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil)
        
        
        return CGSize(width: bounds.width - 16, height: estimatedRect.height + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let vc = OrderDetailViewController(collectionViewLayout: layout)
        vc.orderType = orderType
        vc.order = orders[indexPath.item]
        homeController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
