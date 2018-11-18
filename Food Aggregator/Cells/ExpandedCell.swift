//
//  ExpandedCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 14/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class ExpandedCell: BaseTableViewCell {
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addSubview(stepper)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: stepper)
        addConstraintsWithFormat(format: "H:|-24-[v0][v1(100)]-8-|", views: titleLabel, stepper)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
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
    
}
