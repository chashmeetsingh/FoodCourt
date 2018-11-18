//
//  CartCollectionViewCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 30/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class CartCollectionViewCell: BaseCollectionViewCell {
    
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
//        label.backgroundColor = .red
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "$5.00"
//        label.backgroundColor = .green
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let stepper: GMStepper = {
        let stepper = GMStepper()
        stepper.labelFont = UIFont.systemFont(ofSize: 16)
        stepper.autorepeat = false
        stepper.maximumValue = 20
        stepper.buttonsBackgroundColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        stepper.labelBackgroundColor = .white
        stepper.labelTextColor = .black
        stepper.limitHitAnimationColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        return stepper
    }()
    
    let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "$25.00"
//        label.backgroundColor = .yellow
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(divider)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: divider)
        
        addSubview(itemName)
        addSubview(amountLabel)
        addSubview(stepper)
        addSubview(totalAmountLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-[v1(100)]-8-|", views: itemName, stepper)
        addConstraintsWithFormat(format: "H:|-8-[v0]", views: amountLabel)
        addConstraintsWithFormat(format: "H:[v0]-8-|", views: totalAmountLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0(22)][v1(20)]", views: itemName, amountLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0(22)]-8-[v1]", views: stepper, totalAmountLabel)
    }
    
}
