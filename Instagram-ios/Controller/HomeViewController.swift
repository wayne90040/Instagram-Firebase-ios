//
//  ViewController.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/11.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin()
    
            
        do {
            try Auth.auth().signOut()
        } catch  {
            
        }
    }
    
    // Check login or not
    private func checkLogin(){
        if Auth.auth().currentUser == nil {
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            present(loginVc, animated: true, completion: nil)
        }
    }
}




