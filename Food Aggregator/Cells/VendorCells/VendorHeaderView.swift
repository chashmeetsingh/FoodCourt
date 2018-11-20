//
//  HeaderView.swift
//  Food Aggregator
//
//  Created by Chashmeet on 20/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class VendorHeaderView: UICollectionReusableView {
    
    let orderNumber: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "#234234234"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let personName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "By: Chashmeet Singh"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E0E0E0")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(orderNumber)
        addSubview(personName)
        addSubview(divider)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: orderNumber)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: personName)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-[v1]-8-[v2(1)]|", views: orderNumber, personName, divider)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
