//
//  CartCollectionViewCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 30/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class CartCollectionViewCell: BaseCollectionViewCell {
    
    var item: FoodItem! {
        didSet {
            itemName.text = item.name
            amountLabel.text = "$\(item.cost)"
            stepper.value = Double(item.count)
            totalAmountLabel.text = "$\((item.cost * Double(item.count)).rounded(toPlaces: 2))"
            stepper.tag = item.id
            quantity.text = "\(item.count)"
        }
    }
    
    var delegate: CartViewController?
    
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
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.backgroundColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        stepper.tintColor = .white
        stepper.maximumValue = 20
        stepper.minimumValue = 0
        stepper.layer.borderColor = UIColor.white.cgColor
        stepper.layer.borderWidth = 1
        stepper.addTarget(self, action: #selector(valueUpdated(_:)), for: .valueChanged)
        return stepper
    }()
    
    let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "$25.00"
        return label
    }()
    
    @objc func valueUpdated(_ sender: Any) {
        if let sender = sender as? UIStepper, let item = item {
//            print(sender.value)
            
            if var data = appDelegate.cartItems["\(self.item.foodCourtId)"] {
                let value = Int(sender.value)
                if value > 0 {
                    data["\(item.id)"] = "\(value)"
                } else {
                    data.removeValue(forKey: "\(item.id)")
                }
                
                appDelegate.cartItems["\(self.item.foodCourtId)"] = data
                
                delegate?.getDataForItemsInCart()
                delegate?.collectionView.reloadData()
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(divider)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: divider)
        
        addSubview(itemName)
        addSubview(amountLabel)
        addSubview(stepper)
        addSubview(totalAmountLabel)
        addSubview(quantity)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-[v1(100)][v2(27)]-8-|", views: itemName, stepper, quantity)
        addConstraintsWithFormat(format: "H:|-8-[v0]", views: amountLabel)
        addConstraintsWithFormat(format: "H:[v0]-8-|", views: totalAmountLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0(22)][v1(20)]", views: itemName, amountLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0(22)]", views: stepper)
        addConstraintsWithFormat(format: "V:[v0]-8-|", views: totalAmountLabel)
        addConstraintsWithFormat(format: "V:|-15-[v0(27)]", views: quantity)
    }
    
}
