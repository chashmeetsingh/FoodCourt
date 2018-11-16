//
//  FoodClassCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 14/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class FoodClassCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let upDownButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addSubview(upDownButton)
        addConstraintsWithFormat(format: "H:|-24-[v0][v1]-8-|", views: titleLabel, upDownButton)
        addConstraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: upDownButton)
    }
    
}
