//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/16.
//

import UIKit

// header or footer 為 UICollectionReusableView

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func prfileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func prfileHeaderDidTapFollowerButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func prfileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func prfileHeaderDidTapEditButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Wei Lun Hsu"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "https://github.com/wayne90040"
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile Button", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubView()
        addButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let photoSize = width / 4
        profileImageView.frame = CGRect(x: 5, y: 5, width: photoSize, height: photoSize).integral
        profileImageView.layer.cornerRadius = photoSize / 2
        
        let buttonHeight = photoSize / 2
        let countButtonWidth = (width - 10 - photoSize) / 3
        
        postButton.frame = CGRect(x: profileImageView.right, y: 5,
                                  width: countButtonWidth, height: buttonHeight)
        
        followerButton.frame = CGRect(x: postButton.right, y: 5,
                                  width: countButtonWidth, height: buttonHeight)
        
        followingButton.frame = CGRect(x: followerButton.right, y: 5,
                                  width: countButtonWidth, height: buttonHeight)
        
        editProfileButton.frame = CGRect(x: profileImageView.right, y: postButton.bottom,
                                  width: countButtonWidth * 3, height: buttonHeight)
        
        nameLabel.frame = CGRect(x: 5, y: 5 + profileImageView.bottom,
                                  width: width - 10, height: 50)
        
        let bioSize = bioLabel.sizeThatFits(frame.size)
        // sizeThatFits -> return 最優 Size
        // sizeToFits -> 調用sizeThatFits獲取最優size，並修改為最優size
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom,
                                width: width - 10, height: bioSize.height)
    }
    
    private func addSubView() {
        addSubview(nameLabel)
        addSubview(bioLabel)
        addSubview(profileImageView)
        addSubview(postButton)
        addSubview(followerButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
    }
    
    private func addButtonAction() {
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        followerButton.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }
    
    // MARK: - Button Action
    
    @objc private func didTapPostButton() {
        delegate?.prfileHeaderDidTapPostButton(self)
    }
    
    @objc private func didTapFollowerButton() {
        delegate?.prfileHeaderDidTapFollowerButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.prfileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapEditButton() {
        delegate?.prfileHeaderDidTapEditButton(self)
    }
}
