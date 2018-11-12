//
//  VendorListCollectionView.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem

class VendorListCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var navigationController: UINavigationController!
    
    let images: [UIImage?] = [UIImage(named: "subway-logo"), UIImage(named: "tim-hortons"), UIImage(named: "kfc_logo"), UIImage(named: "starbucks"), UIImage(named: "nyf"), UIImage(named: "wendys"), UIImage(named: "aw"), UIImage(named: "mcd")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VendorCollectionViewCell
        cell.imageView.image = images.randomElement()!
        return cell
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        
//        let cartButton = UIButton()
//        cartButton.setImage(UIImage(named: "cart"), for: .normal)
////        cartButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
//        let item = BBBadgeBarButtonItem(customUIButton: cartButton)
//        item!.badgeValue = "5"
//        self.navigationController.navigationItem.rightBarButtonItem = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.bounds.height, height: self.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FoodChainViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
