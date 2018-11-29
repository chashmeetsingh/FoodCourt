//
//  ClientOrderPastCell.swift
//  Food Court
//
//  Created by Chashmeet on 28/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class ClientOrderPastCell: BaseCollectionViewCell {
    
    let foodCourtName: UILabel = {
        let label = UILabel()
        label.text = "Devonshire Mall"
        label.textColor = .black
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E0E0E0")
        return view
    }()
    
    let orderDetailsButton: MDCButton = {
        let button = MDCButton()
        button.setTitle("Order Details", for: .normal)
        button.backgroundColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        addSubview(foodCourtName)
        //        addSubview(o rderNumberLabel)
        addSubview(divider)
        addSubview(orderDetailsButton)
                
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: divider)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: foodCourtName)
        addConstraintsWithFormat(format: "V:|-8-[v0]", views: foodCourtName)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: orderDetailsButton)
        addConstraintsWithFormat(format: "V:[v0]-11-|", views: orderDetailsButton)
    }
    
}
