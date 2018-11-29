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
            orderNumberLabel.text = "#\(order.id) - \(order.userName)"
//            customerName.text = "By: \(order.userName)"
//            print(order.orderItems)
        }
    }
    
    let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "#234234"
        label.font = UIFont.boldSystemFont(ofSize: 18)
//        label.backgroundColor = .red
        return label
    }()
    
//    let customerName: UILabel = {
//        let label = UILabel()
//        label.text = "By: Customer Name"
//        label.font = UIFont.systemFont(ofSize: 14)
////        label.backgroundColor = .yellow
//        return label
//    }()
    
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
    
    var itemsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 14)
//        label.text = "hjghjghjgjhghjgjhgjhgjhgjhghjgjhgjhgjhgjasdasdsadsadsadsadsadasdsadasdhgj\njghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh\njghgjhgjhghjgjhghjgjhr"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(orderNumberLabel)
        addSubview(divider)
        addSubview(detailArrow)
        addSubview(itemsLabel)
//        addSubview(customerName)
        addConstraintsWithFormat(format: "H:|-16-[v0]-4-[v1(30)]-16-|", views: orderNumberLabel, detailArrow)
//        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: customerName)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:|-8-[v0(20)]-2-[v1(1)]-4-[v2]-4-|", views: orderNumberLabel, divider, itemsLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(30)]", views: detailArrow)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: itemsLabel)
    }
    
}
