//
//  SettingViewController.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/14.
//

import UIKit
import FirebaseAuth
import SafariServices

final class SettingViewController: UIViewController {
    
    private let settingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)  // style == .grouped -> 才會有header
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
    
    private var settingModels = [[SettingModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting"
        view.backgroundColor  = .systemBackground
        
        configureModel()
        
        // add delegate
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        // addSubview
        view.addSubview(settingTableView)
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        settingTableView.frame = view.bounds
    }
    
    private func configureModel() {
        
        // Editting
        settingModels.append([
            SettingModel(title: "Edit Profile"){ [weak self] in
                self?.didTapEditProfile()
            },
            SettingModel(title: "Invite Friends"){ [weak self] in
        
            },
            SettingModel(title: "Save Original Posts"){ [weak self] in
        
            }
            
        ])
        
        // others
        settingModels.append([
            SettingModel(title: "Terms of Service"){ [weak self] in
                self?.openURL(type: .terms)
            },
            SettingModel(title: "Privacy Policy"){ [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingModel(title: "Help / Feed back"){ [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        // Log out
        settingModels.append([
            SettingModel(title: "Logout"){ [weak self] in
                self?.didTapLogout()
            }
        ])
    }
    
    // MARK:- Tap Action
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
    }
    
    enum UrlType {
        case terms, privacy, help
    }
    
    private func openURL(type: UrlType) {
        let urlString: String
        
        switch type {
        case .terms: urlString = "https://help.instagram.com/1215086795543252?helpref=page_content"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapLogout(){
        let sheet = UIAlertController(title: "Logout", message: "確定要登出嗎", preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            
            // Logout
            AuthManager.shared.logout(completion: { [weak self] success in
                if success {

                    // present login view
                    DispatchQueue.main.async {
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        
                        self?.present(vc, animated: true, completion: {
                            self?.navigationController?.popToRootViewController(animated: true)
                            self?.tabBarController?.selectedIndex = 0
                        })
                    }
                }
                else {
                    // 強制閃退
                    fatalError("Logout Error")
                }
            })
        }))
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(sheet, animated: true)
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return settingModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return settingModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = settingModels[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = model.title
        cell.accessoryType = .disclosureIndicator  // cell 的樣式
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = settingModels[indexPath.section][indexPath.row]
        model.handler()
    }
}
