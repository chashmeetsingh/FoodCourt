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
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "success", let userData = results["user"] as? [String : AnyObject] {
                let user = User(dictionary: results)
                self.appDelegate.currentUser = user
                
                let defaults = UserDefaults.standard
                let data = NSKeyedArchiver.archivedData(withRootObject: userData)
                defaults.setValue(data, forKey: "currentUser")
                
                completion(user, results, true, user.message)
            } else {
                completion(nil, nil, false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
    func logoutUser(_ params: [String : AnyObject], _ completion: @escaping (_ results: [String : AnyObject]?, _ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.Logout)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, false, ResponseMessages.InvalidParams)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "successfully logged out" {
                UserDefaults.standard.removeObject(forKey: "currentUser")
                completion(results, true, status)
            } else {
                completion(nil, false, ResponseMessages.ServerError)
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
    
    func getFoodMenu(_ params: [String: AnyObject], _ completion: @escaping(_ foodMenu: [Category]?, _ success: Bool, _ error: String?) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.FoodMenu)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, false, ResponseMessages.ServerError)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "success" {
                let menu = Category.getMenuForRestuarant(dictionary: results[Keys.ItemList] as! [String : AnyObject])
                completion(menu, true, nil)
            } else {
                completion(nil, false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
    func placeOrder(_ params: [String: AnyObject], _ completion: @escaping(_ order: Order?, _ success: Bool, _ error: String?) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.PlaceOrder)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            if let _ = message {
                completion(nil, false, ResponseMessages.ServerError)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "success" {
                let orderDetails = results[Keys.CustomerOrder] as? [String : AnyObject]
                
                let order = Order(dictionary: orderDetails!)
                
                completion(order, true, nil)
            } else {
                completion(nil, false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
}
