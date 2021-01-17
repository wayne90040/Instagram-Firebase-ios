//
//  IGFeedPostTableViewCell.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/14.
//

import UIKit

class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure
        
    }

}
