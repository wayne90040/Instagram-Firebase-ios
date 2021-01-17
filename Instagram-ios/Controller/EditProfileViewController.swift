//
//  EditProfileViewController.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/15.
//

import UIKit

struct EditProfileModel {
    let label: String
    let placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController {
    
    private let mainTabeView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: EditProfileTableViewCell.identifier)
        
        return tableView
    }()
    
    private var editProfileModels = [[EditProfileModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Profile"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        
        mainTabeView.delegate = self
        mainTabeView.dataSource = self
        mainTabeView.tableHeaderView = tableHeaderView()
        configureModels()
        
        view.addSubview(mainTabeView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTabeView.frame = view.bounds
    }
    
    private func configureModels() {
        // name, username, website, bio
        let sectionLabel1 = ["Name", "Username", "Websit", "Bio"]
        var sectionModel1 = [EditProfileModel]()
        
        for label in sectionLabel1 {
            let model = EditProfileModel(label: label, placeholder: "Enter \(label)...", value: nil)
            sectionModel1.append(model)
        }
        editProfileModels.append(sectionModel1)
        
        // email, phone, gender
        let setionLabel2 = ["Email", "Phone", "Gender"]
        var sectionModel2 = [EditProfileModel]()
        
        for label in setionLabel2 {
            let model = EditProfileModel(label: label, placeholder: "Enter \(label) ...", value: nil)
            sectionModel2.append(model)
        }
        
        editProfileModels.append(sectionModel2)
    }
    
    private func tableHeaderView() -> UIView {
        // Add UIView
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height / 4).integral)
        
        // Add Image Button
        let size = headerView.height / 1.5
        let photoButton = UIButton(frame: CGRect(x: (headerView.width - size) / 2, y: (headerView.height - size) / 2,
                                                  width: size, height: size))
        photoButton.layer.masksToBounds = true
        photoButton.layer.cornerRadius = size / 2.0
        photoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        photoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        photoButton.layer.borderWidth = 1.0
        
        photoButton.addTarget(self, action: #selector(didTapProfilePic), for: .touchUpInside)
        
        headerView.addSubview(photoButton)
        
        return headerView
    }
    
    // dismiss 返回前一次呼叫 present 顯示的 ViewController
    @objc private func didTapSave() {
       // save to database
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapProfilePic() {
        let sheet = UIAlertController(title: "Edit Profile", message: "Change Profile Picture", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            // present camera
        }))
        sheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            // present photolibrary
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(sheet, animated: true, completion: nil)
    }
}

// MARK:- TableView

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return editProfileModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editProfileModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileTableViewCell.identifier,
                                                 for: indexPath) as! EditProfileTableViewCell
        let model = editProfileModels[indexPath.section][indexPath.row]
        cell.configure(with: model)
        cell.delegate = self
        
        return cell
    }
}

// MARK:-

extension EditProfileViewController: EditProfileTableViewDelegate {
    
    func editTableViewCell(_ cell: EditProfileTableViewCell, didUpdateField model: EditProfileModel) {
        
    }
}
