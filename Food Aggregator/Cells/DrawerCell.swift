//
//  DrawerCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 31/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class DrawerCell: BaseCollectionViewCell {
    
    let menuItemLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Profile"
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(divider)
        addSubview(menuItemLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "H:|-8-[v0]|", views: menuItemLabel)
        addConstraintsWithFormat(format: "V:|[v0][v1(1)]|", views: menuItemLabel, divider)
    }

}
