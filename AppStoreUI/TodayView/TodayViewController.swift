//
//  TodayViewController.swift
//  AppStoreUI
//
//  Created by Jackson Pitcher on 12/26/19.
//  Copyright © 2019 Jackson Pitcher. All rights reserved.
//

import UIKit

class TodayViewController: BaseListController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    var results = [FeedResult]()
    
    var items = [TodayItem]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: .whiteLarge)
        av.color = .darkGray
        av.startAnimating()
        av.hidesWhenStopped = true
        return av
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blurView)
        blurView.fillSuperview()
        blurView.alpha = 0
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        
        fetchData()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9515665479, green: 0.9515665479, blue: 0.9515665479, alpha: 1)
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    var topGrossing: AppGroup?
    var gamesGroup: AppGroup?
    
    func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        Service.shared.fetchTopGrossing { (appGroup, err) in
            self.topGrossing = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, err) in
            self.gamesGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            
            self.items = [
                TodayItem.init(category: "Life Hack", title: "Utilizing your time", image: #imageLiteral(resourceName: "garden"), description: "These apps help organize a more time efficient lifesytle", backgroundColor: .white, cellType: .single, apps: []),
                TodayItem.init(category: "Daily List", title: self.topGrossing?.feed.title ?? "", image: #imageLiteral(resourceName: "star"), description: "", backgroundColor: .white, cellType: .multiple, apps: self.topGrossing?.feed.results ?? []),
                TodayItem.init(category: "Daily List", title: self.gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: self.gamesGroup?.feed.results ?? []),
                TodayItem.init(category: "Holiday Travel", title: "Holiday Travel Methods", image: #imageLiteral(resourceName: "holiday").withRenderingMode(.alwaysOriginal), description: "Find out the best plans and locations for travel during the holiday", backgroundColor: #colorLiteral(red: 1, green: 0.9734603675, blue: 0.678339975, alpha: 1), cellType: .single, apps: [])
            ]
            
            self.collectionView.reloadData()
        }
    }
    
    var fullScreenController: FullScreenController!
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullController = MultipleAppsController(mode: .fullscreen)
        fullController.apps = self.items[indexPath.item].apps
        present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch items[indexPath.item].cellType {
        case .multiple:
            showDailyListFullScreen(indexPath)
        default:
            showSingleAppFullScreen(indexPath: indexPath)
        }
    }
    
    fileprivate func setupSingleAppFullScreenController(_ indexPath: IndexPath) {
        let fullScreenController = FullScreenController()
        
        fullScreenController.todayItem = items[indexPath.row]
        fullScreenController.dismissHandler = {
            self.handleFullScreenDismissal()
        }
        fullScreenController.view.layer.cornerRadius = 16
        self.fullScreenController = fullScreenController
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        fullScreenController.view.addGestureRecognizer(gesture)
        gesture.delegate = self
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    var fullScreenBeginOffset: CGFloat = 0
    
    @objc func handleDrag(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            fullScreenBeginOffset = fullScreenController.tableView.contentOffset.y
        }
        
        let translationY = gesture.translation(in: fullScreenController.view).y
        
        if fullScreenController.tableView.contentOffset.y > 0 {
            return
        }
        
        if gesture.state == .changed {
            if translationY > 0 {
                let offset = translationY - fullScreenBeginOffset
                
                var scale = 1 - offset / 1000
                
                scale = min(1, scale)
                scale = max(0.5, scale)
                        
                let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
                self.fullScreenController.view.transform = transform
            }
        } else if gesture.state == .ended {
            if translationY > 0 {
                handleFullScreenDismissal()
            }
        }
    }
    
    fileprivate func setupStartingAnimatingPosition(_ indexPath: IndexPath) {
        let fullScreenView = fullScreenController.view!
        view.addSubview(fullScreenView)
        
        addChild(fullScreenController)
            
        self.collectionView.isUserInteractionEnabled = false
                
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        print(cell.frame)
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
    }
    
    fileprivate func beginFullScreenAnimation(_ indexPath: IndexPath) {
       UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
        
            self.blurView.alpha = 1
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            self.tabBarController?.tabBar.isHidden = true
            
            guard let cell = self.fullScreenController.tableView.cellForRow(at: [0, 0]) as? FullScreenHeaderCell else { return }
            cell.exitButton.alpha = 1
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    fileprivate func showSingleAppFullScreen(indexPath: IndexPath) {
        setupSingleAppFullScreenController(indexPath)
        
        setupStartingAnimatingPosition(indexPath)
        
        beginFullScreenAnimation(indexPath)
    }
    
    var startingFrame: CGRect?
    
    @objc func handleFullScreenDismissal() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.tabBarController?.tabBar.isHidden = false
            
            self.fullScreenController.tableView.contentOffset = .zero
            self.fullScreenController.view.transform = .identity
            
            self.blurView.alpha = 0
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = .identity
            
            guard let cell = self.fullScreenController.tableView.cellForRow(at: [0, 0]) as? FullScreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 24
            cell.exitButton.alpha = 0
            cell.layoutIfNeeded()
            
        }, completion: { _ in
            self.collectionView.isUserInteractionEnabled = true
            self.fullScreenController.view.removeFromSuperview()
            self.fullScreenController.removeFromParent()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIDType = items[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDType, for: indexPath) as! BaseTodayCell
        
        cell.todayItem = items[indexPath.item]
        
        (cell as? MultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAppTaps)))
        
        return cell
    }
    
    @objc func handleAppTaps(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        
        var superview = collectionView?.superview
        
        while superview != nil {
            if let cell = superview as? MultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
                let apps = self.items[indexPath.item].apps
                       
                let fullController = MultipleAppsController(mode: .fullscreen)
                fullController.apps = apps
                present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
            }
            superview = superview?.superview
        }
    }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
