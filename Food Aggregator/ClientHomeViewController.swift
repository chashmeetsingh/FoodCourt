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

class ClientHomeViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var drawerOpen = false
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    // 139, 8, 35 -> Zomato red
    // 240, 240, 240 -> Zomato gray

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewFlowLayout)
//        tableView.backgroundColor = .red
        self.view.addSubview(collectionView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        self.title = "Food Courts"
        
        collectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FoodChainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openDrawer))
        
//        let cartButton = UIButton()
//        cartButton.setImage(UIImage(named: "cart"), for: .normal)
//        cartButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
//        let item = BBBadgeBarButtonItem(customUIButton: cartButton)
//        item!.badgeValue = "5"
//        self.navigationItem.rightBarButtonItem = item
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
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

extension ClientHomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodChainCollectionViewCell
        cell.vendorCollectionView.navigationController = self.navigationController
        switch indexPath.item {
        case 0:
            cell.foodChainLabel.text = "Devonshire Food Court"
        case 1:
            cell.foodChainLabel.text = "Tecumseh Food Court"
        case 2:
            cell.foodChainLabel.text = "Ambience Mall Food Court"
        case 3:
            cell.foodChainLabel.text = "UWindsor Food Court"
        default:
            cell.foodChainLabel.text = ""
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width - 16, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FoodChainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
