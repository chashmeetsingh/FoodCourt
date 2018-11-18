//
//  FoodCourt.swift
//  Food Aggregator
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class FoodCourt: NSObject {
    
    let id: String
    let foodCourtName: String
    let address: String
    let city: String
    let openTime: String
    let closeTime: String
    let restaurants: [Restaurant]
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary[Client.Keys.Id] as? String ?? ""
        foodCourtName = dictionary[Client.Keys.FoodCourtName] as? String ?? ""
        address = dictionary[Client.Keys.Address] as? String ?? ""
        city = dictionary[Client.Keys.City] as? String ?? ""
        openTime = dictionary[Client.Keys.OpenTime] as? String ?? ""
        closeTime = dictionary[Client.Keys.CloseTime] as? String ?? ""
        restaurants = Restaurant.getRestaurants(dictionary: dictionary[Client.Keys.Restaurants] as? [[String : AnyObject]] ?? [[:]])
    }
    
    static func getFoodCourts(dictionary: [[String : AnyObject]]) -> [FoodCourt] {
        var foodCourts: [FoodCourt] = []
        for item in dictionary {
            foodCourts.append(FoodCourt(dictionary: item))
        }
        return foodCourts
    }
    
}
