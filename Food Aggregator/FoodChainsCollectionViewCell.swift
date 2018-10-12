//
//  FoodChainsTableViewCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class FoodChainsCollectionViewCell: BaseCollectionViewCell {
    
    let foodChainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .red
        return label
    }()

    override func setupViews() {
        super.setupViews()
        
        setupCell()
    }
    
    func setupCell() {
        // food chain label
        addSubview(foodChainLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: foodChainLabel)
        addConstraintsWithFormat(format: "V:|-4-[v0(12)]", views: foodChainLabel)
    }

}
