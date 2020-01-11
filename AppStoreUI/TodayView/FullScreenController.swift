//
//  FullScreenController.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 1/2/20.
//  Copyright © 2020 Jackson Pitcher. All rights reserved.
//

import UIKit

class FullScreenController: UITableViewController {
    
    var dismissHandler: (() ->())?
    var todayItem: TodayItem?
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
        let translationY = -90 - UIApplication.shared.statusBarFrame.height

        let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: translationY) : .identity
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.floatingContainerView.transform = transform
        })
    }
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
        
        setupFloatingControls()
    }
    
    let floatingContainerView = UIView()
    
    @objc func handleTap() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.floatingContainerView.transform = .init(translationX: 0, y: -90)
        })
    }
    
    fileprivate func setupFloatingControls() {
        floatingContainerView.clipsToBounds = true
        floatingContainerView.backgroundColor = .red
        view.addSubview(floatingContainerView)
        floatingContainerView.layer.cornerRadius = 16
        floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16), size: .init(width: 0, height: 100))
        
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurEffect)
        blurEffect.fillSuperview()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        let imageView = UIImageView(cornerRadius: 16)
        imageView.image = #imageLiteral(resourceName: "garden").withRenderingMode(.alwaysOriginal)
        imageView.clipsToBounds = true

        let getButton = UIButton(title: "GET")
        getButton.setTitleColor(.white, for: .normal)
        getButton.backgroundColor = UIColor.darkGray
        getButton.layer.cornerRadius = 16
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        let stackView = UIStackView(arrangedSubviews: [
            imageView, UILabel(text: "Life Hack \n Utilizing your time", font: .boldSystemFont(ofSize: 16), numberOfLines: 2), getButton
        ], customSpacing: 12)

        floatingContainerView.addSubview(stackView)
        stackView.fillSuperview()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = FullScreenHeaderCell()
            cell.exitButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            cell.todayCell.todayItem = todayItem
            cell.todayCell.layer.cornerRadius = 0
            cell.clipsToBounds = true
            cell.todayCell.backgroundView = nil
            return cell
        }
        let cell = FullScreenDescriptionCell()
        return cell
    }
    
    @objc func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
