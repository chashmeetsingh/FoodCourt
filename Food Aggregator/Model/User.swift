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
    let name: String
    
    init(dictionary: [String : AnyObject]) {
        accessToken = dictionary[Client.Keys.Token] as? String ?? ""
        emailID = dictionary[Client.Keys.Email] as? String ?? ""
        message = dictionary[Client.Keys.Message] as? String ?? ""
        name = dictionary[Client.Keys.Name] as? String ?? ""
    }
    
}
