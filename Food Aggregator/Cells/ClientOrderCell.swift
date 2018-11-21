//
//  OrderCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 01/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class ClientOrderCell: BaseCollectionViewCell {
    
    let foodCourtName: UILabel = {
        let label = UILabel()
        label.text = "Devonshire Mall"
        label.textColor = .red
//        label.backgroundColor = .black
        return label
    }()
    
    let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Order Number: #34133"
        label.textColor = .red
//        label.backgroundColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E0E0E0")
        return view
    }()
    
    let orderStatusButton: MDCButton = {
        let button = MDCButton()
        button.setTitle("Order Status", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    let orderDetailsButton: MDCButton = {
        let button = MDCButton()
        button.setTitle("Order Details", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(foodCourtName)
        addSubview(orderNumberLabel)
        addSubview(divider)
        addSubview(orderStatusButton)
        addSubview(orderDetailsButton)
        
        let width = ( self.frame.width - ( 8 * 3 ) ) / 2
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: divider)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: foodCourtName)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: orderNumberLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-[v1]", views: foodCourtName, orderNumberLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(\(width))]-8-[v1(\(width))]-8-|", views: orderStatusButton, orderDetailsButton)
        addConstraintsWithFormat(format: "V:[v0]-11-|", views: orderStatusButton)
        addConstraintsWithFormat(format: "V:[v0]-11-|", views: orderDetailsButton)
    }
    
}
