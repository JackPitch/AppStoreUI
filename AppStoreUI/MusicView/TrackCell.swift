//
//  TrackCell.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 1/11/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.constrainWidth(constant: 80)
        imageView.backgroundColor = .darkGray
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, VerticalStackView(arrangedSubViews: [nameLabel, subtitleLabel], spacing: 4)
        ], customSpacing: 16)
        
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
    }
    
    let imageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "Track name", font: .boldSystemFont(ofSize: 18))
    let subtitleLabel = UILabel(text: "Subtitles", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
