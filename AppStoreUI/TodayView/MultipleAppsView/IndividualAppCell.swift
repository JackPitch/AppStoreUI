//
//  IndividualAppCell.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 1/5/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class IndividualAppCell: UICollectionViewCell {
    
    var app: FeedResult! {
        didSet {
            nameLabel.text = app.name
            companyLabel.text = app.artistName
            
            imageView.sd_setImage(with: URL(string: app.artworkUrl100), completed: nil)
        }
    }
    
    let imageView = UIImageView(cornerRadius: 8)
    
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 15))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 11))
    
    let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .purple
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainWidth(constant: 70)
        getButton.constrainHeight(constant: 32)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.layer.cornerRadius = 32 / 2
        
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubViews: [nameLabel, companyLabel], spacing: 4), getButton])
        stackView.spacing = 16
        
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview()
        
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -10, right: 0), size: .init(width: frame.width - 68, height: 0.5))
    }
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 0.3, alpha: 0.3)
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
