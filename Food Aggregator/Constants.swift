//
//  Constants.swift
//  Food Aggregator
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

extension Client {
    
    struct ResponseMessages {
        static let InvalidParams = "Email ID / Password incorrect"
        static let ServerError = "Problem connecting to server!"
        static let SignedOut = "Successfully logged out"
        static let PasswordInvalid = "Password chosen is invalid."
    }
    
    struct APIURL {
        static let IPAddress = "http://167.99.179.118:8081"
    }
    
    struct Methods {
        static let Login = "/signIn"
    }
    
    struct Keys {
        static let Email = "email"
        static let Password = "password"
        static let Status = "status"
        static let Token = "token"
        static let Message = "message"
        static let Name = "name"
    }
    
    struct Colors {
        static let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    }
    
}
