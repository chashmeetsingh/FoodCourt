//
//  User.swift
//  Food Aggregator
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let accessToken: String
    let emailID: String
    let message: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let userRole: String
    let restaurantId: Int
    
    init(dictionary: [String : AnyObject]) {
        accessToken = dictionary[Client.Keys.Token] as? String ?? ""
        emailID = dictionary[Client.Keys.EmailID] as? String ?? ""
        message = dictionary[Client.Keys.Message] as? String ?? ""
        firstName = dictionary[Client.Keys.FirstName] as? String ?? ""
        lastName = dictionary[Client.Keys.LastName] as? String ?? ""
        phoneNumber = dictionary[Client.Keys.PhoneNumber] as? String ?? ""
        userRole = dictionary[Client.Keys.UserRole] as? String ?? ""
        restaurantId = dictionary[Client.Keys.RestaurantId] as? Int ?? 0
    }
    
    var name: String {
        return "\(self.firstName) \(self.lastName)"
    }
    
}
