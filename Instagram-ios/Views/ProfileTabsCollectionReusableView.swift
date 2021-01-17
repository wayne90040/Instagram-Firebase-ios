//
//  ProfileTabsCollectionReusableView.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/16.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject  {
    func profileTabDidTapGridButton()
    func profileTabDidTapTaggedButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.tintColor = .lightGray
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        // addSubView
        addSubview(gridButton)
        addSubview(taggedButton)
        
        // addAction
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - Constants.padding * 2
        let gridX = ((width / 2) - size) / 2
        
        gridButton.frame = CGRect(x: gridX, y: Constants.padding, width: size, height: size)
        taggedButton.frame = CGRect(x: gridX + (width / 2), y: Constants.padding, width: size, height: size)
    }
    
    // MARK: Action
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.profileTabDidTapGridButton()
    }
    
    @objc private func didTapTaggedButton() {
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.profileTabDidTapTaggedButton()
    }
}
