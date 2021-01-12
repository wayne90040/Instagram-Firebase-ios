//
//  AuthManager.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/11.
//

import Foundation
import Firebase

class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func register(username: String, email: String, password: String, completion: @escaping(Bool) -> Void){
        
        // Check username and email is available
        DatabaseManager.shared.checkUsernameEmail(username: username, email: email, completion: { available in
            if available{
                
                // Create Account
                Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
                    guard result != nil, error == nil else{
                        return
                    }
                    
                    // Insert Database
                    DatabaseManager.shared.insertUsername(username: username, email: email, completion: { success in
                        guard success else {
                            completion(false)
                            return
                        }
                        
                        completion(true)
                    })
                    
                })
            }else{
                completion(false)
            }
        })
    }
    
    public func login(username: String?, email: String?, password: String, completion: @escaping(Bool) -> Void){
        if let email = email{
            // email log in
            Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
                guard result != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            })
        }else if let username = username{
            
            // username log in
            print("username log in:\(username)")
        }
    }
}
