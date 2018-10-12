//
//  BaseTableViewCell.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() { }

}
