//
//  Convenience.swift
//  Food Aggregator
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import Foundation

extension Client {
    
    // MARK: - Auth Methods
    func loginUser(_ params: [String: AnyObject], _ completion: @escaping(_ user: User?, _ results: [String: AnyObject]?, _ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.Login)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, nil, false, ResponseMessages.InvalidParams)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "success" {
                let user = User(dictionary: results)
                self.appDelegate.currentUser = user
                
                let defaults = UserDefaults.standard
                defaults.setValue(results, forKey: "currentUser")
                
                completion(user, results, true, user.message)
            } else {
                completion(nil, nil, false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
    // MARK: - Food Court Methods
    func getFoodCourts(_ params: [String: AnyObject], _ completion: @escaping(_ foodCourts: [FoodCourt]?, _ success: Bool, _ error: String?) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.FoodCourts)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, false, ResponseMessages.ServerError)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "success" {
                let fcList = results[Keys.FCList] as! [[String : AnyObject]]
                let foodCourts = FoodCourt.getFoodCourts(dictionary: fcList)
                completion(foodCourts, true, nil)
            } else {
                completion(nil, false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
}
