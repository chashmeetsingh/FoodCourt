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
    var orders: [Order]!
    
    var homeController: VendorHomeViewController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(OrderItemCell.self, forCellWithReuseIdentifier: "orderItemCell")
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if orderType == OrderType.active {
            return 5
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderItemCell", for: indexPath) as! OrderItemCell
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let vc = OrderDetailViewController(collectionViewLayout: layout)
        vc.orderType = orderType
        homeController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
