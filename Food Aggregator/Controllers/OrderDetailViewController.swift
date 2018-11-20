//
//  OrderDetailViewController.swift
//  VendorFoodApp
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class OrderDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var orderType: OrderType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(OrderDetailCell.self, forCellWithReuseIdentifier: "orderDetailCell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(FinalPriceView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "finalPriceView")
        collectionView.backgroundColor = .white
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "orderDetailCell", for: indexPath) as! OrderDetailCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! VendorHeaderView
            return view
        case UICollectionView.elementKindSectionFooter:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "finalPriceView", for: indexPath) as! FooterView
            
            if orderType == OrderType.current {
                view.markCompleteButton.backgroundColor = UIColor(hex: "#00C853")
                view.markCompleteButton.isUserInteractionEnabled = true
                view.markCompleteButton.setTitle("Mark complete", for: .normal)
            } else {
                view.markCompleteButton.backgroundColor = .gray
                view.markCompleteButton.isUserInteractionEnabled = false
                view.markCompleteButton.setTitle("Order complete", for: .normal)
            }
            
            return view
        default:
            return UICollectionReusableView(frame: CGRect.zero)
        }
    }

}
