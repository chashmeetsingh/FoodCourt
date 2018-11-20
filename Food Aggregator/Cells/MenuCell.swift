//
//  MenuCell.swift
//  VendorFoodApp
//
//  Created by Chashmeet on 11/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class MenuCell: BaseCollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            titleLabel.textColor = isHighlighted ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addConstraintsWithFormat(format: "H:[v0]", views: titleLabel)
        addConstraintsWithFormat(format: "V:[v0]", views: titleLabel)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
