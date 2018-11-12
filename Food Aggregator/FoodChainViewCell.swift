//
//  FoodChainViewCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 11/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class FoodChainViewCell: BaseCollectionViewCell {

    var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
    }
    
}
