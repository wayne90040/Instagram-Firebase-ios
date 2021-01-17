//
//  ProfileViewController.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/14.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    private var userPosts = [UserPost]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done, target: self, action: #selector(didTapSetting))
        
        // CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)  // 處理 section 的間距
        
        let size = (view.width - 4) / 3  // 4 = 中間兩條 + left + right
        layout.itemSize = CGSize(width: size, height: size)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Register Cell
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        // Register Header
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self,
                             forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        collectionView?.register(ProfileTabsCollectionReusableView.self,
                             forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        collectionView?.backgroundColor = .red
        
        // delegate
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    // to Setting view
    @objc private func didTapSetting() {
        let vc = SettingViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK:- UICollectionView

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // 設置 reuse 的 section 的 header or footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 使用kind參數來分辨這時是要設置 header 或 footer
        guard kind == UICollectionView.elementKindSectionHeader else {
            // footer
            return UICollectionReusableView()
        }
        
        
        // 設置 header
        if indexPath.section == 0 {
            // header info
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier,
                                                                         for: indexPath) as! ProfileInfoHeaderCollectionReusableView
            header.delegate = self
            return header
            
        }
        
        // header tab
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                                                                     for: indexPath) as! ProfileTabsCollectionReusableView
        header.delegate = self
        return header
    }
    
    // Set Header height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height / 3)
        }
        
        
        return CGSize(width: collectionView.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // ProfileInfo header
        if section == 0 {
            return 0
        }
//        return userPosts.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier,
                                                      for: indexPath) as! PhotoCollectionViewCell
//        let userPost = userPosts[indexPath.row]
        cell.configure(debug: "car")
 //       cell.configure(with: userPost)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let userPost = userPosts[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = PostViewController(userPost: nil)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate

extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    
    func prfileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        
        // scroll to the post
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func prfileHeaderDidTapFollowerButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var testFollowers = [UserRelationship]()
        for x in 0 ..< 10 {
            testFollowers.append(UserRelationship(name: "@wayne", username: "Wei Lun", type: x % 2 == 0 ? .following: .notFollowing))
        }
        
        let vc = ListViewController(people: testFollowers)
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func prfileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var testFollowings = [UserRelationship]()
        for x in 0 ..< 10 {
            testFollowings.append(UserRelationship(name: "@wayne", username: "Wei Lun", type: x % 2 == 0 ? .following: .notFollowing))
        }
        
        let vc = ListViewController(people: testFollowings)
        
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func prfileHeaderDidTapEditButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - ProfileTabsCollectionReusableViewDelegate

extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
   
    func profileTabDidTapGridButton() {
        // reload collectionView
    }
    
    func profileTabDidTapTaggedButton() {
        // reload collectionView
    }
}

