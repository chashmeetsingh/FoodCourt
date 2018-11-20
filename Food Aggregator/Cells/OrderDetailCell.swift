//
//  OrderDetailCell.swift
//  VendorFoodApp
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class OrderDetailCell: BaseCollectionViewCell {
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.backgroundColor = UIColor(hex: "#E0E0E0")
        return view
    }()
    
    let itemName: UILabel = {
        let label = UILabel()
        label.text = "Junior Chicken"
        label.textColor = .black
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "$5.00"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "$25.00"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(divider)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: divider)
        
        addSubview(itemName)
        addSubview(amountLabel)
        addSubview(totalAmountLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: itemName)
        addConstraintsWithFormat(format: "H:|-8-[v0]", views: amountLabel)
        addConstraintsWithFormat(format: "H:[v0]-8-|", views: totalAmountLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0][v1]", views: itemName, amountLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]", views: totalAmountLabel)
    }
    
}
