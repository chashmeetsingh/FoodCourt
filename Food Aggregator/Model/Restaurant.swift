//
//  Restaurant.swift
//  Food Aggregator
//
//  Created by Chashmeet on 14/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class Restaurant: NSObject {
    
    let id: String
    let fcId: String
    let name: String
    let iconName: String
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary[Client.Keys.Id] as? String ?? ""
        fcId = dictionary[Client.Keys.FCID] as? String ?? ""
        name = dictionary[Client.Keys.Name] as? String ?? ""
        iconName = dictionary[Client.Keys.IconName] as? String ?? ""
    }
    
    static func getRestaurants(dictionary: [[String : AnyObject]]) -> [Restaurant] {
        var restaurants: [Restaurant] = []
        for item in dictionary {
            restaurants.append(Restaurant(dictionary: item))
        }
        return restaurants
    }
    
}
