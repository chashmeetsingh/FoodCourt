//
//  OrderItemCell.swift
//  VendorFoodApp
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class OrderItemCell: BaseCollectionViewCell {
    
    var order: Order! {
        didSet {
            orderNumberLabel.text = "#\(order.id)"
            customerName.text = "By: \(order.userName)"
            print(order.orderItems)
        }
    }
    
    let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "#234234"
        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.backgroundColor = .red
        return label
    }()
    
    let customerName: UILabel = {
        let label = UILabel()
        label.text = "By: Customer Name"
        label.font = UIFont.systemFont(ofSize: 14)
//        label.backgroundColor = .yellow
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E0E0E0")
        return view
    }()
    
    let detailArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "detail_arrow")
        return iv
    }()
    
    let itemsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "hjghjghjgjhghjgjhgjhgjhgjhghjgjhgjhgjhgjasdasdsadsadsadsadsadasdsadasdhgj\njghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh\njghgjhgjhghjgjhghjgjhr"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(orderNumberLabel)
        addSubview(divider)
        addSubview(detailArrow)
        addSubview(itemsLabel)
        addSubview(customerName)
        addConstraintsWithFormat(format: "H:|-8-[v0]-4-[v1(30)]-8-|", views: orderNumberLabel, detailArrow)
        addConstraintsWithFormat(format: "H:|-8-[v0]-42-|", views: customerName)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:|-8-[v0(20)][v1(16)]-2-[v2(1)]-4-[v3]-4-|", views: orderNumberLabel, customerName, divider, itemsLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(30)]", views: detailArrow)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: itemsLabel)
    }
    
}
