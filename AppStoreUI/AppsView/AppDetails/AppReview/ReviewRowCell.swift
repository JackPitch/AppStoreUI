//
//  ReviewRowCell.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 12/30/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
    }
    
    let reviewsController = ReviewsController()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
