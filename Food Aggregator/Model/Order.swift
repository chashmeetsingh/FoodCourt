//
//  File.swift
//  Food Aggregator
//
//  Created by Chashmeet on 18/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import Foundation

struct Order {
    
    let foodCourtId: Int
    let foodCourtName: String
    let id: Int
    let orderTime: Int
    let userId: Int
    let userName: String
    let totalCost: Double
    let orderStatus: String
    let preparationTime: Int
    var orderItems = [OrderItem]()
    
    init(dictionary: [String : AnyObject]) {
        foodCourtId = dictionary[Client.Keys.FoodCourtId] as? Int ?? 0
        foodCourtName = dictionary[Client.Keys.FoodCourtName] as? String ?? ""
        id = dictionary[Client.Keys.Id] as? Int ?? 0
        orderTime = dictionary[Client.Keys.OrderTime] as? Int ?? 0
        userId = dictionary[Client.Keys.UserId] as? Int ?? 0
        userName = dictionary[Client.Keys.Username] as? String ?? ""
        totalCost = dictionary[Client.Keys.TotalCost] as? Double ?? 0.0
        orderStatus = dictionary[Client.Keys.OrderStatus] as? String ?? ""
        preparationTime = dictionary[Client.Keys.PreparationTime] as? Int ?? 0
    }
    
    static func getOrderList(dictionary: [[String : AnyObject]]) -> [Order] {
        var orders = [Order]()
        for order in dictionary {
            if let customerOrder = order[Client.Keys.CustomerOrder] as? [String : AnyObject], let orderItemsList = order[Client.Keys.OrderItemList] as? [[String : AnyObject]] {
                var order = Order(dictionary: customerOrder)
                order.orderItems = OrderItem.getOrderItemsList(dictionary: orderItemsList)
                orders.append(order)
            }
        }
        return orders
    }
    
}
