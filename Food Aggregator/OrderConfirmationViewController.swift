//
//  OrderConfirmationViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 31/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    let confirmationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = "Thankyou for your order.\nYou order number is:"
        label.numberOfLines = 2
        return label
    }()
    
    let orderLabel: UILabel = {
        let label = UILabel()
        label.textColor = hexStringToUIColor(hex: "#757575")
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "#31431"
        label.textAlignment = .center
        return label
    }()
    
    let orderPickupLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = "Please pick up your order in"
        label.numberOfLines = 2
        return label
    }()
    
    let orderPickupTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = hexStringToUIColor(hex: "#757575")
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "25 minutes"
        label.textAlignment = .center
        return label
    }()
    
    let yourOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Your Orders", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = hexStringToUIColor(hex: "#00E676")
        button.addTarget(self, action: #selector(yourOrdersButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(confirmationLabel)
        view.addSubview(orderLabel)
        view.addSubview(orderPickupLabel)
        view.addSubview(orderPickupTimeLabel)
        view.addSubview(yourOrderButton)
        
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: confirmationLabel)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: orderLabel)
        view.addConstraintsWithFormat(format: "V:|-16-[v0]-16-[v1]", views: confirmationLabel, orderLabel)
        view.addConstraint(NSLayoutConstraint(item: yourOrderButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: orderPickupLabel)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: orderPickupTimeLabel)
        view.addConstraintsWithFormat(format: "H:[v0(200)]", views: yourOrderButton)
        view.addConstraintsWithFormat(format: "V:[v0]-16-[v1]-16-[v2]-32-|", views: yourOrderButton, orderPickupLabel, orderPickupTimeLabel)
    }
    
    @objc func yourOrdersButtonTapped() {
        var viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        
        for controller in viewControllers.reversed() {
            if !controller.isKind(of: HomeViewController.self) {
                viewControllers.removeLast()
            } else {
                break
            }
        }
        let vc = OrdersViewController()
        viewControllers.insert(vc, at: viewControllers.count)
        navigationController?.setViewControllers(viewControllers, animated: true)
    }

}