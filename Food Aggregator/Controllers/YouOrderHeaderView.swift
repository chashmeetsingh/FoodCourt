//
//  YouOrderHeaderView.swift
//  Food Court
//
//  Created by Chashmeet on 28/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class YourOrderHeaderView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(label)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: label)
        addConstraintsWithFormat(format: "V:|[v0]|", views: label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
