//
//  Convenience.swift
//  Food Aggregator
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

extension Client {
    
    // MARK: - Auth Methods
    func loginUser(_ params: [String: AnyObject], _ completion: @escaping(_ user: User?, _ results: [String: AnyObject]?, _ success: Bool, _ error: String) -> Void) {
        
        let url = getApiUrl(APIURL.IPAddress, Methods.Login)
        
        _ = makeRequest(url, .post, [:], parameters: params, completion: { (results, message) in
            
            if let _ = message {
                completion(nil, nil, false, ResponseMessages.InvalidParams)
            } else if let results = results as? [String: AnyObject] {
                let user = User(dictionary: results)
                self.appDelegate.currentUser = user
                completion(user, results, true, user.message)
            }
            return
        })
        
    }
    
}
