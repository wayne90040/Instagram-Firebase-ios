//
//  EditProfileTableViewCell.swift
//  Instagram-ios
//
//  Created by Wei Lun Hsu on 2021/1/15.
//

import UIKit


protocol EditProfileTableViewDelegate: AnyObject {
    func editTableViewCell(_ cell: EditProfileTableViewCell, didUpdateField model: EditProfileModel)
}

class EditProfileTableViewCell: UITableViewCell {
    
    static let identifier = "EditProfileTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        return textField
    }()
    
    public weak var delegate: EditProfileTableViewDelegate?
    private var model: EditProfileModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        field.delegate = self
        model = nil
        contentView.addSubview(titleLabel)
        contentView.addSubview(field)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 5, y: 0,
                                  width: contentView.width / 3, height: contentView.height)
        field.frame = CGRect(x: titleLabel.right + 5, y: 0,
                             width: contentView.width - 10 - titleLabel.width, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("prepareForReuse")
//        titleLabel.text = model.label
//        field.placeholder = model.placeholder
//        field.text = model.value
    }
    
    public func configure(with model: EditProfileModel) {
        selectionStyle = .none
        self.model = model
        titleLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
}

// MARK:- UITextFieldDelegate

extension EditProfileTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Set value
        model?.value = textField.text
        guard let model = model else { return true }
        delegate?.editTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        
        return true
    }
}
