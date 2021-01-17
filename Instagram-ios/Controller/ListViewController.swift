//
//  ListViewController.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/17.
//

import UIKit

class ListViewController: UIViewController {
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserFollowTableViewCell.self,
                           forCellReuseIdentifier: UserFollowTableViewCell.identifier)
        tableView.rowHeight = 75
        
        return tableView
    }()
    
    private let people: [UserRelationship]
    
    init(people: [UserRelationship]) {
        self.people = people
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground    
        mainTableView.delegate = self
        mainTableView.dataSource = self
        view.addSubview(mainTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTableView.frame = view.bounds
    }
}

// MARK: -

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier,
                                                 for: indexPath) as! UserFollowTableViewCell
        let person = people[indexPath.row]
        cell.configuer(with: person)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UserFollowTableViewCellDelegate{
    
    func didTapFollowUnFollowButton(model: UserRelationship) {
        switch model.type {
        
        case .following:
            // perform firebase update to unfollow
            break
        case .notFollowing:
            // perform firebase update to follow
            break
        }
    }
}
