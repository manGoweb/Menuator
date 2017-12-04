//
//  Menuator.swift
//  Menuator
//
//  Created by Aguele/Rafaj on 05/09/2017.
//  Copyright (c) 2017 Ford. All rights reserved.
//

import UIKit
import SnapKit


public class Menuator: UIView {
    
    // MARK: - Public interface
    
    public var lineView = UIView()
    
    public typealias PerformAction = () -> ()
    public typealias ConfigureLabel = ((_ label: inout UILabel) -> ())
    
    public var leftMargin: CGFloat = 0 {
        didSet {
            lineView.snp.updateConstraints { (make) in
                make.left.equalTo(leftMargin)
            }
            layoutIfNeeded()
            
            collectionView.reloadData()
        }
    }
    
    public var offsetChanged: ((_ offset: CGFloat)->())?
    
    public var itemSpacing: CGFloat = 20 {
        didSet {
            collectionLayout.minimumInteritemSpacing = itemSpacing
            collectionView.reloadData()
        }
    }
    
    public var itemPadding: CGFloat {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var floatViewHeight: CGFloat = 2 {
        didSet {
            floatView.snp.updateConstraints { (make) in
                make.height.equalTo(self.floatViewHeight)
            }
            setNeedsLayout()
        }
    }
    
    public var lineViewHeight: CGFloat = 2 {
        didSet {
            lineView.snp.updateConstraints { (make) in
                make.height.equalTo(self.lineViewHeight)
            }
            setNeedsLayout()
        }
    }
    
    public var floatViewColor: UIColor = .black {
        didSet {
            floatView.backgroundColor = floatViewColor
        }
    }
    
    public var lineViewColor: UIColor = .white {
        didSet {
            lineView.backgroundColor = lineViewColor
        }
    }
    
    public var roundedCorners: Bool = false {
        didSet {
            let cornerRadius: CGFloat
            if roundedCorners {
                cornerRadius = (lineViewHeight / 2)
            }
            else {
                cornerRadius = 0
            }
            floatView.layer.cornerRadius = cornerRadius
            lineView.layer.cornerRadius = cornerRadius
        }
    }
    
    public var currentIndex: Int = 0 {
        didSet {
            if currentIndex >= menuatorController.menuItems.count {
                fatalError("Menuator index is out of bounds")
            }
            let indexPath = IndexPath(item: currentIndex, section: 0)
            let cellFrame = collectionView.layoutAttributesForItem(at: indexPath)!.frame
            menuatorController.didTapCell?(indexPath, cellFrame)
        }
    }
    
    // MARK: Initialization
    
    public init(frame: CGRect = CGRect.zero, leftMargin: CGFloat = 0) {
        self.leftMargin = leftMargin
        self.collectionLayout = UICollectionViewFlowLayout.init()
        self.collectionLayout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionLayout)
        self.itemPadding = self.itemSpacing
        self.menuatorController.currentX = (self.itemPadding + leftMargin)
        
        super.init(frame: frame)
        clipsToBounds = true

        configureMenuatorController()
        configurelineView()
        configureCollectionView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Elements
    
    public func add(menuItem text: String, configure: ConfigureLabel? = nil, didBecomeActive action: @escaping PerformAction) {
        guard let _ = initialMenuItem else {
            let menuItem =  MenuatorDataController.MenuItem(text: text, configure: configure, action: action)
            configureInitialItem(menuItem: menuItem)
            return
        }
        menuatorController.menuItems.append( MenuatorDataController.MenuItem(text: text, configure: configure, action: action))
        collectionView.reloadData()
    }
    
    // MARK: - Private interface
    
    var floatView = UIView()
    var collectionView: UICollectionView
    var menuatorController =  MenuatorDataController()
    var collectionLayout : UICollectionViewFlowLayout
    var initialMenuItem: MenuatorDataController.MenuItem?
    
    var selectViewPage: ((IndexPath)->())? // Clicked on a menu item -> View
    
    // MARK: Configure elements
    
    private func configureMenuatorController() {
        menuatorController.didTapCell = { indexPath, cellFrame in
            let menuItem = self.menuatorController.menuItems[indexPath.row]
            menuItem.action()
            
            let newX = (cellFrame.origin.x - self.collectionView.contentOffset.x)
            self.menuatorController.currentX = newX
            self.floatView.snp.updateConstraints { (make) in
                make.width.equalTo(cellFrame.width)
                make.left.equalTo(newX)
            }
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState], animations: {
                self.layoutIfNeeded()
            }, completion: nil)
            
            self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            
            self.selectViewPage?(indexPath)
        }
        
        menuatorController.requestXUpdate = { value in
            self.floatView.snp.updateConstraints { (make) in
                make.left.equalTo(value)
            }
            self.layoutIfNeeded()
        }
        
        menuatorController.offsetChanged = { x in
            self.offsetChanged?(x)
            
            self.lineView.snp.updateConstraints { (make) in
                var m = (self.leftMargin - x)
                if m < 0 {
                    m = 0
                }
                make.left.equalTo(m)
            }
            self.layoutIfNeeded()
        }
        
        menuatorController.padding = {
            return self.itemPadding
        }
        
        menuatorController.leftMargin = {
            return self.leftMargin
        }
    }
    
    private func configureInitialItem(menuItem: MenuatorDataController.MenuItem)  {
        var label = UILabel()
        menuItem.configure?(&label)
        initialMenuItem = menuItem
        let width = menuItem.text.width(usingFont: label.font)
        configureFloat(with: width)
        menuatorController.menuItems.append(menuItem)
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(MenuatorCollectionViewCell.self, forCellWithReuseIdentifier: MenuatorCollectionViewCell.identifier)
        collectionView.delegate = menuatorController
        collectionView.dataSource = menuatorController
        
        collectionLayout.minimumInteritemSpacing = itemSpacing
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func configurelineView() {
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftMargin)
            make.right.equalTo(0)
            make.height.equalTo(self.floatViewHeight)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureFloat(with width: CGFloat) {
        addSubview(floatView)
        floatView.snp.makeConstraints { (make) in
            make.left.equalTo((self.itemPadding + self.leftMargin))
            make.width.equalTo(width)
            make.height.equalTo(self.floatViewHeight)
            make.bottom.equalToSuperview()
        }
    }
}
