//
//  Category.swift
//  Food Aggregator
//
//  Created by Chashmeet on 16/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import Foundation

class Category: NSObject {
    
    let name: String
    let foodItems: [FoodItem]
    
    init(categoryName: String, data: [FoodItem]) {
        name = categoryName
        foodItems = data
    }
    
    static func getMenuForRestuarant(dictionary: [String : AnyObject]) -> [Category] {
        var foodMenu: [Category] = []
        for (category, data) in dictionary {
            if let data = data as? [[String : AnyObject]] {
                let foodItems = FoodItem.getFoodItems(dictionary: data)
                let category = Category(categoryName: category, data: foodItems)
                foodMenu.append(category)
            }
        }
        return foodMenu
    }
    
}
