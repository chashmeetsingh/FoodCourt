//
//  FoodItem.swift
//  Food Aggregator
//
//  Created by Chashmeet on 16/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import Foundation

class FoodItem: NSObject {
    
    let cost: Double
    let foodCourtId: Int
    let foodCourtName: String
    let id: Int
    let name: String
    let restaurantId: Int
    let restaurantName: String
    let timeToPrepareInMinutes: Int
    let category: String
    var count = 0
    
    init(dictionary: [String : AnyObject]) {
        cost = dictionary[Client.Keys.Cost] as? Double ?? 0
        foodCourtId = dictionary[Client.Keys.FoodCourtId] as? Int ?? 0
        foodCourtName = dictionary[Client.Keys.FoodCourtName] as? String ?? ""
        id = dictionary[Client.Keys.Id] as? Int ?? 0
        name = dictionary[Client.Keys.Name] as? String ?? ""
        restaurantId = dictionary[Client.Keys.RestaurantId] as? Int ?? 0
        timeToPrepareInMinutes = dictionary[Client.Keys.TimeToPrepareInMinutes] as? Int ?? 0
        category = dictionary[Client.Keys.Category] as? String ?? ""
        restaurantName = dictionary[Client.Keys.RestaurantName] as? String ?? ""
    }
    
    static func getFoodItems(dictionary: [[String : AnyObject]]) -> [FoodItem] {
        var foodItems: [FoodItem] = []
        for item in dictionary {
            let foodItem = FoodItem(dictionary: item)
            foodItems.append(foodItem)
        }
        return foodItems
    }
 
}
