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
    
    var foodCourts: [FoodCourt] = []
    
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
        self.view.addSubview(collectionView)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        self.title = "Food Courts"
        
        collectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FoodChainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openDrawer))
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        getFoodCourts()
    }
    
    @objc func openDrawer() {
        if drawerOpen {
            appDelegate.centerContainer?.closeDrawer(animated: true, completion: nil)
        } else {
            appDelegate.centerContainer?.open(.left, animated: true, completion: nil)
        }
        drawerOpen = !drawerOpen
    }
    
    func getFoodCourts() {
        self.view.makeToastActivity(.center)
        
        let params = [
            Client.Keys.City: "Windsor"
        ]
        
        Client.sharedInstance.getFoodCourts(params as [String : AnyObject]) { (foodCourts, success, error) in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.foodCourts = foodCourts!
                self.collectionView.reloadData()
                self.appDelegate.foodCourts = foodCourts!
            }
        }
    }

}

extension ClientHomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodCourts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodChainCollectionViewCell
        cell.navigationController = self.navigationController
        let item = foodCourts[indexPath.item]
        cell.foodCourt = item
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
        vc.foodCourt = foodCourts[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
