//
//  DrawerHeaderCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 20/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class DrawerHeaderCell: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "person")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .black
        iv.backgroundColor = .white
        iv.layer.cornerRadius = 42
        return iv
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(label)
        addConstraintsWithFormat(format: "V:|-8-[v0(84)]-8-|", views: imageView)
        addConstraintsWithFormat(format: "V:|-8-[v0(84)]-8-|", views: label)
        addConstraintsWithFormat(format: "H:|-8-[v0(84)]-12-[v1]-8-|", views: imageView, label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
