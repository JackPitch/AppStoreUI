//
//  TodayCell.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 1/1/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.description
            backgroundColor = todayItem.backgroundColor
            
            backgroundView?.backgroundColor = todayItem.backgroundColor
        }
    }
    
    var topConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let stackView = VerticalStackView(arrangedSubViews: [
            categoryLabel, titleLabel, imageContainerView, descriptionLabel
        ], spacing: 8)
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
    }
    
    let categoryLabel = UILabel(text: "Life Hacks", font: .boldSystemFont(ofSize: 20))
       let titleLabel = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 30), numberOfLines: 2)
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden").withRenderingMode(.alwaysOriginal))
    let descriptionLabel = UILabel(text: "Organize your life in a smart way", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
