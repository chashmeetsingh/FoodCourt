//
//  HeaderView.swift
//  Food Aggregator
//
//  Created by Chashmeet on 30/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let jointName: UILabel = {
        let label = UILabel()
        label.textColor = .black
//        label.backgroundColor = .blue
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        return iv
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E0E0E0")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(jointName)
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "V:|-14-[v0(44)]-14-|", views: jointName)
        addConstraintsWithFormat(format: "V:|-4-[v0(64)]-4-|", views: imageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(64)]-8-[v1]-8-|", views: imageView, jointName)
        
        addSubview(divider)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: divider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
