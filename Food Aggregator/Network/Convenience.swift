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
    
    func placeOrder(_ params: [String: AnyObject], _ completion: @escaping(_ foodMenu: [Category]?, _ success: Bool, _ error: String?) -> Void) {
        
        
        
//        var request = URLRequest(url: URL(string: url)!)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        var postString = ""
//
//        for (key, value) in params {
//            postString += "\(key)=\(value)"
//        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            let url = getApiUrl(APIURL.IPAddress, Methods.PlaceOrder)
            let request = NSMutableURLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            print(jsonData, params)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                    
                    print("Result -> \(result)")
                    
                } catch {
                    print("Error -> \(error)")
                }
            }
            
            task.resume()
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
