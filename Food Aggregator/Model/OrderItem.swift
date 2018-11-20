//
//  OrderItem.swift
//  VendorFoodApp
//
//  Created by Chashmeet on 19/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import Foundation

struct OrderItem {
    
    let id: Int
    let name: String
    let orderId: Int
    let restaurantId: Int
    let restaurantName: String
    let itemCost: Double
    let quantity: Int
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary[Client.Keys.Id] as? Int ?? 0
        name = dictionary[Client.Keys.Name] as? String ?? ""
        orderId = dictionary[Client.Keys.OrderId] as? Int ?? 0
        restaurantId = dictionary[Client.Keys.RestaurantId] as? Int ?? 0
        restaurantName = dictionary[Client.Keys.RestaurantName] as? String ?? ""
        itemCost = dictionary[Client.Keys.ItemCost] as? Double ?? 0.0
        quantity = dictionary[Client.Keys.Quantity] as? Int ?? 0
    }
    
    static func getOrderItemsList(dictionary: [[String : AnyObject]]) -> [OrderItem] {
        var ordersList = [OrderItem]()
        for item in dictionary {
            ordersList.append(OrderItem(dictionary: item))
        }
        return ordersList
    }
    
}
