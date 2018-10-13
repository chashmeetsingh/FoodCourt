//
//  VendsorListCollectionView.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class VendorListCollectionView: UICollectionView {

    override func numberOfItems(inSection section: Int) -> Int {
        return 10
    }
    
    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = self.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VendorCollectionViewCell
        return cell
    }

}
