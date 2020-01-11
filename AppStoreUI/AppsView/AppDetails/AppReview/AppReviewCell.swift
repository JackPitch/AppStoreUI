//
//  AppReviewCell.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 12/30/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(reviewLabel)
        reviewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        addSubview(reviewController.view)
        reviewController.view.anchor(top: reviewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    let reviewController = ReviewsController()
    
    let reviewLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 25))
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
