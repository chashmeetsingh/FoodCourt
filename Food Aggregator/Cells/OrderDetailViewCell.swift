//
//  OrderDetailViewCell.swift
//  Food Court
//
//  Created by Chashmeet on 29/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class OrderDetailViewCell: BaseCollectionViewCell {
    
    var item: OrderItem! {
        didSet {
            itemName.text = item.name
            amountLabel.text = "$\(item.itemCost)"
            totalAmountLabel.text = "$\((item.itemCost * Double(item.quantity)).rounded(toPlaces: 2))"
            quantity.text = "\(item.quantity)"
        }
    }
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    let quantity: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.layer.borderColor = UIColor.black.cgColor
        //        label.layer.borderWidth = 0.5
        label.textAlignment = .center
        return label
    }()
    
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
    
    let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "$25.00"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(divider)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: divider)
        
        addSubview(itemName)
        addSubview(amountLabel)
        addSubview(totalAmountLabel)
        addSubview(quantity)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-[v1(27)]-8-|", views: itemName, quantity)
        addConstraintsWithFormat(format: "H:|-8-[v0]", views: amountLabel)
        addConstraintsWithFormat(format: "H:[v0]-8-|", views: totalAmountLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(22)][v1(20)]", views: itemName, amountLabel)
        addConstraintsWithFormat(format: "V:[v0]-8-|", views: totalAmountLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(27)]", views: quantity)
    }
    
}
