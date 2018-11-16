//
//  FoodChainCollectionViewCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class FoodChainCollectionViewCell: BaseCollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var navigationController: UINavigationController!
    
    var foodCourt: FoodCourt! {
        didSet {
            foodChainLabel.text = foodCourt.address
            vendorCollectionView.reloadData()
        }
    }
    
    let foodChainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var vendorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        collectionView.register(VendorCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        setupCell()
    }
    
    func setupCell() {
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        addSubview(foodChainLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: foodChainLabel)
        
        addSubview(vendorCollectionView)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: vendorCollectionView)
        
        addConstraintsWithFormat(format: "V:|-4-[v0(32)]-8-[v1]-4-|", views: foodChainLabel, vendorCollectionView)
        layer.cornerRadius = 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodCourt.restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VendorCollectionViewCell
        let restaurant = foodCourt.restaurants[indexPath.item]
        cell.imageView.image = UIImage(named: restaurant.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.vendorCollectionView.frame.height, height: self.vendorCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FoodChainViewController()
        vc.foodCourt = foodCourt
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
