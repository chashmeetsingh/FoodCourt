//
//  VendorHomeViewController.swift
//  VendorFoodApp
//
//  Created by Chashmeet on 08/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import Toast_Swift

class VendorHomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.homeController = self
        menuBar.backgroundColor = .red
        return menuBar
    }()
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    var activeOrders = [Order]()
    var completedOrders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false

        title = "Orders"
        setupCollectionView()
        setupMenuBar()
        
        configureNavigationBar()
        
        getOrders()
    }
    
    fileprivate func configureNavigationBar() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutUser))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    func getOrders() {
        
        let params = [
            Client.Keys.Email: "jalaj@yopmail.com",
            Client.Keys.Token: "yololo",
            Client.Keys.RestaurantId: "3"
        ]
        
        self.view.makeToastActivity(.center)
        Client.sharedInstance.getOrders(params as [String : AnyObject]) { (activeOrders, completedOrders, results, success, message) in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.completedOrders = completedOrders!
                self.activeOrders = activeOrders!
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func logoutUser() {
        self.view.makeToastActivity(.center)
        
        let params = [
            Client.Keys.Email: appDelegate.currentUser!.emailID,
            Client.Keys.Token: appDelegate.currentUser!.accessToken
        ]
        
        Client.sharedInstance.logoutUser(params as [String : AnyObject]) { (_, success, message) in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                if success {
                    self.navigationController?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView?.backgroundColor = .white
        collectionView.register(VendorOrderCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    private func setupMenuBar() {        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        let guide = view.safeAreaLayoutGuide
        menuBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalbarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index: Int = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VendorOrderCell
        if indexPath.item == 0 {
            cell.orderType = OrderType.active
        } else {
            cell.orderType = OrderType.complete
        }
        cell.homeController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

}
