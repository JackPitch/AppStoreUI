//
//  MultipleAppCell.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 1/5/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class MultipleAppCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            
            multipleAppsController.apps = todayItem.apps
            multipleAppsController.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = VerticalStackView(arrangedSubViews: [
            categoryLabel, titleLabel, multipleAppsController.view
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        
        backgroundColor = .white
        layer.cornerRadius = 16
    }
    
    let categoryLabel = UILabel(text: "Life Hacks", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 30), numberOfLines: 2)
    
    let multipleAppsController = MultipleAppsController(mode: .small)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
