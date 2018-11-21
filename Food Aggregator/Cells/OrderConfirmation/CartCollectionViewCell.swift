//
//  CartCollectionViewCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 30/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class CartCollectionViewCell: BaseCollectionViewCell {
    
    var item: FoodItem!
    var delegate: CartViewController?
    var indexPath: IndexPath!
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
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
    
    lazy var stepper: GMStepper = {
        let stepper = GMStepper()
        stepper.labelFont = UIFont.systemFont(ofSize: 16)
        stepper.autorepeat = false
        stepper.maximumValue = 20
        stepper.buttonsBackgroundColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        stepper.labelBackgroundColor = .white
        stepper.labelTextColor = .black
        stepper.limitHitAnimationColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        stepper.addTarget(self, action: #selector(valueUpdated(_:)), for: .valueChanged)
        return stepper
    }()
    
    let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "$25.00"
//        label.backgroundColor = .yellow
        return label
    }()
    
    var tapped = true
    
    @objc func valueUpdated(_ sender: Any) {
        if let _ = sender as? GMStepper, let item = item, tapped {
            if var data = appDelegate.cartItems["\(self.item.foodCourtId)"] {
                let value = Int(stepper.value)
                if value > 0 {
                    data["\(item.id)"] = "\(value)"
                    tapped = true
                } else {
                    data.removeValue(forKey: "\(item.id)")
                    tapped = false
                }
                appDelegate.cartItems["\(self.item.foodCourtId)"] = data
                delegate?.getDataForItemsInCart()
            }
            print(appDelegate.cartItems)
        } else {
            tapped = true
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
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-[v1(100)]-8-|", views: itemName, stepper)
        addConstraintsWithFormat(format: "H:|-8-[v0]", views: amountLabel)
        addConstraintsWithFormat(format: "H:[v0]-8-|", views: totalAmountLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0(22)][v1(20)]", views: itemName, amountLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0(22)]-8-[v1]", views: stepper, totalAmountLabel)
    }
    
}
