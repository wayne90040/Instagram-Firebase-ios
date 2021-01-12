//
//  DatabaseManager.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/11.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    static let shared = DatabaseManager()
    private let ref = Database.database().reference()
    
    // MARK: - Public
    
    /// check username and email is available
    public func checkUsernameEmail(username: String, email: String, completion: @escaping(Bool) -> Void){
        completion(true)
    }
    
    public func insertUsername(username: String, email: String, completion: @escaping(Bool) -> Void){
        ref.child(email.beSafeEmail()).setValue(["username": username], withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
}
