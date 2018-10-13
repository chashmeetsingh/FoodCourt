//
//  FoodChainCollectionViewCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class FoodChainCollectionViewCell: BaseCollectionViewCell {
    
    let foodChainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .red
        return label
    }()
    
    var vendorCollectionView: VendorListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = VendorListCollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .purple
        collectionView.register(VendorCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        setupCell()
    }
    
    func setupCell() {
        backgroundColor = .green
        
        addSubview(foodChainLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: foodChainLabel)
        
        addSubview(vendorCollectionView)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: vendorCollectionView)
        
        addConstraintsWithFormat(format: "V:|-4-[v0(20)]-4-[v1]-4-|", views: foodChainLabel, vendorCollectionView)
    }
    
}
