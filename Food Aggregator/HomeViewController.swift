//
//  HomeViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import MMDrawerController
import BBBadgeBarButtonItem

class HomeViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var drawerOpen = false
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewFlowLayout)
//        tableView.backgroundColor = .red
        self.view.addSubview(collectionView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        self.title = "Homescreen"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FoodChainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openDrawer))
        
        let cartButton = UIButton()
        cartButton.setImage(UIImage(named: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        let item = BBBadgeBarButtonItem(customUIButton: cartButton)
        item!.badgeValue = "5"
        self.navigationItem.rightBarButtonItem = item
        
    }
    
    @objc func openDrawer() {
        if drawerOpen {
            appDelegate.centerContainer?.closeDrawer(animated: true, completion: nil)
        } else {
            appDelegate.centerContainer?.open(.left, animated: true, completion: nil)
        }
        drawerOpen = !drawerOpen
    }
    
    @objc func openCart() {
        let vc = CartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodChainCollectionViewCell
        cell.vendorCollectionView.navigationController = self.navigationController
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width - 16, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FoodChainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
