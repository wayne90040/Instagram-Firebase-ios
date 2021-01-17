//
//  StorageManager.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/11.
//

import Foundation
import FirebaseStorage

class StorageManager {
    let shared = StorageManager()
    let ref = Storage.storage().reference()
    
    /// upload media
    public func uploadMedia(with model: UserPost, completion: @escaping(Result<URL, StorageError>) -> Void) {
    
    }
    
    public func download(with path: String, completion: @escaping(Result<URL, StorageError>) -> Void) {
        ref.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.faildToDownload))
                return
            }
            
            completion(.success(url))
        })
    }
}


// MARK:- Storage Error

enum StorageError: Error {
    case faildToDownload
}
