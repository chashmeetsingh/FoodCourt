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
    func loginUser(_ params: [String: AnyObject], _ completion: @escaping(_ user: User?, _ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.Login)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, false, ResponseMessages.InvalidParams)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, let userData = results["user"] as? [String : AnyObject] {
                
                if status == "success" {
                    let user = User(dictionary: results)
                    
                    let data = NSKeyedArchiver.archivedData(withRootObject: userData)
                    UserDefaults.standard.setValue(data, forKey: "currentUser")
                    
                    completion(user, true, user.message)
                } else {
                    let message = results["reason"] as! String
                    completion(nil, false, message)
                }
                
            } else {
                completion(nil, false, ResponseMessages.InvalidParams)
            }
            return
        })
        
    }
    
    func signUpUser(_ params: [String: AnyObject], _ completion: @escaping(_ user: User?, _ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.Register)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, false, ResponseMessages.InvalidParams)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "success" {
//                let user = User(dictionary: results)
//                self.appDelegate.currentUser = user
                
//                let data = NSKeyedArchiver.archivedData(withRootObject: userData)
//                UserDefaults.standard.setValue(data, forKey: "currentUser")
                
                completion(nil, true, "no error")
            } else {
                completion(nil, false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
    func logoutUser(_ params: [String : AnyObject], _ completion: @escaping (_ results: [String : AnyObject]?, _ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.Logout)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, false, ResponseMessages.InvalidParams)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String {
                UserDefaults.standard.removeObject(forKey: "currentUser")
//                self.appDelegate.currentUser = nil
                self.appDelegate.cartItems = [:]
                completion(results, true, status)
            } else {
                completion(nil, false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
    func updateUserProfile(_ params: [String : AnyObject], _ completion: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.UpdateProfile)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(false, ResponseMessages.InvalidParams)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "success" {
                completion(true, status)
            } else {
                completion(false, ResponseMessages.ServerError)
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
                if let orderDetails = results[Keys.Customerorder] as? [String : AnyObject] {
                    let order = Order(dictionary: orderDetails)
                    
                    completion(order, true, nil)
                } else {
                    completion(nil, false, "Error")
                }
            } else {
                completion(nil, false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
    func getOrders(_ params: [String: AnyObject], _ completion: @escaping(_ activeOrders: [Order]?, _ completedOrders: [Order]?, _ results: [String: AnyObject]?, _ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.GetOrders)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, nil, nil, false, ResponseMessages.InvalidParams)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "success", let orderList = results[Keys.OrderList] as? [String : AnyObject], let activeOrdersList = orderList[Keys.Active] as? [[String : AnyObject]], let completedOrderList = orderList[Keys.Completed] as? [[String : AnyObject]] {
                let activeOrders = Order.getOrderList(dictionary: activeOrdersList)
                let completedOrders = Order.getOrderList(dictionary: completedOrderList)
                completion(activeOrders, completedOrders, results, true, status)
            } else {
                completion(nil, nil, nil, false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
    func updateOrderStatus(_ params: [String: AnyObject], _ completion: @escaping( _ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.UpdateOrder)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(false, ResponseMessages.InvalidParams)
            } else if let results = results as? [String: AnyObject], let status = results[Keys.Status] as? String, status == "success" {
                completion(true, status)
            } else {
                completion(false, ResponseMessages.ServerError)
            }
            return
        })
        
    }
    
}
