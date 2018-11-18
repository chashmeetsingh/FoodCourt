//
//  FoodChainViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem

class FoodChainViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var foodCourt: FoodCourt! {
        didSet {
            appDelegate.currentFoodCourt = foodCourt
        }
    }
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    var cartItemsCount: String {
        get {
            var count: Int  = 0
            if let currentFoodCourtCart = appDelegate.cartItems[foodCourt.id] {
                for item in currentFoodCourtCart {
                    count += Int(item.value)!
                }
            }
            return "\(count)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Restaurants"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(FoodChainViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        self.collectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    func setCartIconBadge(_ value: String = "") {
        let cartButton = UIButton()
        cartButton.setImage(UIImage(named: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        let item = BBBadgeBarButtonItem(customUIButton: cartButton)
        item!.badgeValue = cartItemsCount
        self.navigationItem.rightBarButtonItem = item
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setCartIconBadge(cartItemsCount)
    }
    
    @objc func openCart() {
        let vc = CartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension FoodChainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodCourt.restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodChainViewCell
        let restaurant = foodCourt.restaurants[indexPath.item]
        cell.imageView.image = UIImage(named: restaurant.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width / 2 - 8, height: view.frame.width / 2 - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 4, bottom: 4, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FoodJointMenuViewController()
        vc.restaurant = foodCourt.restaurants[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
