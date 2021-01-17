//
//  LoginViewController.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/11.
//

import UIKit
import SafariServices


class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username or Email"
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
    
        return button
    }()
    
    private let termButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Police", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
        return button
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        
        let backgroundImage = UIImageView(image: UIImage(named: "gradient"))
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setdelegate()
        addSubviews()
        
        // Set Button Action
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        termButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height / 3)
        usernameTextField.frame = CGRect(x: 25, y: headerView.bottom + 10, width: view.width - 50, height: 52)
        passwordTextField.frame = CGRect(x: 25, y: usernameTextField.bottom + 10, width: view.width - 50, height: 52)
        loginButton.frame = CGRect(x: 25, y: passwordTextField.bottom + 10, width: view.width - 50, height: 52)
        createButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width - 50 , height: 52)
        termButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 100, width: view.width - 20, height: 50)
        privacyButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 50, width: view.width - 20, height: 50)
        configurHeaderView()
    }
    
    private func setdelegate(){
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    private func configurHeaderView(){
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        // Add logo
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        headerView.addSubview(logoImageView)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x: headerView.width / 4, y: view.safeAreaInsets.top, width: headerView.width / 2, height: headerView.height - view.safeAreaInsets.top)
        
    }
    
    private func addSubviews(){
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(createButton)
        view.addSubview(termButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
    }
    
    // MARK:- Button Action
    
    @objc private func didTapLoginButton(){
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        // 判斷是否有空值
        guard let usernameEmail = usernameTextField.text, !usernameEmail.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        var username: String?
        var email: String?
        
        // 判斷是 username or email
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            // email
            email = usernameEmail
        }else{
            username = usernameEmail
        }
        
        AuthManager.shared.login(username: username, email: email, password: password, completion: { [weak self] success in
            DispatchQueue.main.async {
                // 主執行緒 非同步 -> 更新 UI
                
                guard let strongSelf = self else{
                    return
                }
                
                if success{
                    strongSelf.dismiss(animated: true, completion: nil)
                }else{
                    
                    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                    strongSelf.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    @objc private func didTapCreateButton(){
        let vc = RegisterViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.title = "Create Account"
        
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func didTapTermsButton(){
        guard  let url = URL(string: "https://www.facebook.com/help/instagram/termsofuse") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapPrivacyButton(){
        guard  let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
}


// MARK:- UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            usernameTextField.becomeFirstResponder()
        }
        
        return true
    }
}
