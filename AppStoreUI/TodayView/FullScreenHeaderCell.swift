//
//  FullScreenHeaderCell.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 1/3/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class FullScreenHeaderCell: UITableViewCell {
    
    let todayCell = TodayCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(todayCell)
        todayCell.fillSuperview()
        addSubview(exitButton)
        exitButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 36, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 40))
    }
    
    let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
