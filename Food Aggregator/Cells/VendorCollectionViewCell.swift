//
//  VendorCollectionViewCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class VendorCollectionViewCell: BaseCollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = .black
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        layer.cornerRadius = 12
        
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
    }
    
}
