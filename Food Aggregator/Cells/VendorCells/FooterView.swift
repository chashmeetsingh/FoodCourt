//
//  VendorTotalCostView.swift
//  Food Aggregator
//
//  Created by Chashmeet on 20/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class FooterView: UICollectionReusableView {
    
    var order: Order!
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    let subtotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtotal"
        return label
    }()
    
    let taxesAndChargesLabel: UILabel = {
        let label = UILabel()
        label.text = "Taxes & charges"
        return label
    }()
    
    let subtotalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$25"
        label.textAlignment = .right
        return label
    }()
    
    let taxesAndChargesAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$3.25"
        label.textAlignment = .right
        return label
    }()
    
    let grandTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Grand Total"
        return label
    }()
    
    let grandTotalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 28.25"
        label.textAlignment = .right
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E0E0E0")
        return view
    }()
    
    let divider1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E0E0E0")
        return view
    }()
    
    let markCompleteButton: MDCButton = {
        let button = MDCButton()
        button.backgroundColor = UIColor(hex: "#00C853")
        button.setTitle("Confirm Order", for: .normal)
        button.addTarget(self, action: #selector(markOrderComplete), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(subtotalLabel)
        addSubview(taxesAndChargesLabel)
        addSubview(subtotalAmountLabel)
        addSubview(taxesAndChargesAmountLabel)
        addSubview(grandTotalLabel)
        addSubview(grandTotalAmountLabel)
        addSubview(divider)
        addSubview(divider1)
        addSubview(markCompleteButton)
        
        addConstraintsWithFormat(format: "H:|-8-[v0][v1]-8-|", views: subtotalLabel, subtotalAmountLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0][v1]-8-|", views: taxesAndChargesLabel, taxesAndChargesAmountLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0][v1]-8-|", views: grandTotalLabel, grandTotalAmountLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider1)
        addConstraintsWithFormat(format: "V:|-16-[v0]-4-[v1]-4-[v2(1)]-4-[v3]-4-[v4(1)]", views: subtotalLabel, taxesAndChargesLabel, divider, grandTotalLabel, divider1)
        addConstraintsWithFormat(format: "V:|-16-[v0]-4-[v1]-9-[v2]", views: subtotalAmountLabel, taxesAndChargesAmountLabel, grandTotalAmountLabel)
        
        addConstraintsWithFormat(format: "V:[v0]-4-|", views: markCompleteButton)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: markCompleteButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func markOrderComplete() {
        let params = [
            Client.Keys.Email: appDelegate.currentUser!.emailID,
            Client.Keys.Token: appDelegate.currentUser!.accessToken,
            Client.Keys.OrderId: order.id,
            Client.Keys.OrderStatus: "completed"
        ] as [String : AnyObject]
        
        Client.sharedInstance.updateOrderStatus(params) { (success, message) in
            DispatchQueue.main.async {
                if success {
                    self.markCompleteButton.backgroundColor = .gray
                    self.markCompleteButton.isUserInteractionEnabled = false
                    self.markCompleteButton.setTitle("Order complete", for: .normal)
                }
            }
        }
    }
    
}
