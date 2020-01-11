//
//  LoadingFooter.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 1/11/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class LoadingFooter: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let av = UIActivityIndicatorView(style: .whiteLarge)
        av.color = .darkGray
        av.startAnimating()
        
        let label = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        
        let stackView = VerticalStackView(arrangedSubViews: [
            av, label
        ], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
