//
//  UserFollowerTableViewCell.swift
//  Instagram
//
//  Created by Duy Nguyễn on 02/01/2023.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: Userelationship)
}

enum FollowState {
    case following, not_following
}

struct Userelationship {
    let username: String
    let name: String
    let type: FollowState
}
class UserFollowTableViewCell: UITableViewCell {

    static let identifier = "UserFollowtableviewCell"
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private  var model: Userelationship?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "@master"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@master"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        
        followButton.addTarget(self,
                               action: #selector(didTapFollowButton),
                               for: .touchUpInside)
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return 
        }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: Userelationship) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
        case .following:
             //show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            //show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
        
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height-6,
                                        height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth,
                                    y: (contentView.width-40)/2,
                                    width: buttonWidth,
                                    height: 40)
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(x: profileImageView.right+5,
                                 y: 0,
                                 width: contentView.width-3-profileImageView.width,
                                 height: labelHeight)
        usernameLabel.frame = CGRect(x: profileImageView.right+5,
                                     y: nameLabel.bottom,
                                 width: contentView.width-3-profileImageView.width,
                                 height: labelHeight)
    }
}
