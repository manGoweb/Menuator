//
//  MenuatorView.swift
//  Menuator
//
//  Created by Aguele/Rafaj on 01/11/2017.
//  Copyright (c) 2017 Ford. All rights reserved.
//

import Foundation
import UIKit


public protocol MenuatorViewDataSource {
    func page(index: Int, menuatorView: MenuatorView) -> UIView
}

public protocol MenuatorViewDelegate {
    func didScrollTo(index: Int, menuatorView: MenuatorView)
}


public class MenuatorView: UIView {
    
    let menuatorViewDataController: MenuatorViewDataController
    var collectionLayout : UICollectionViewFlowLayout
    let collectionView: UICollectionView
    
    public var dataSource: MenuatorViewDataSource? {
        didSet {
            reloadData()
        }
    }
    
    public var delegate: MenuatorViewDelegate?
    
    public func reloadData() {
        collectionView.reloadData()
    }
    
    // MARK: Initialization
    
    required public init(menuator: Menuator) {
        self.menuatorViewDataController = MenuatorViewDataController(menuator: menuator)
        
        self.collectionLayout = UICollectionViewFlowLayout.init()
        self.collectionLayout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionLayout)
        
        super.init(frame: CGRect.zero)
        
        menuator.selectViewPage = { indexPath in
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.delegate?.didScrollTo(index: indexPath.item, menuatorView: self)
        }

        menuator.menuatorView = self
        
        configureCollectionView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(MenuatorViewPageCell.self, forCellWithReuseIdentifier: MenuatorViewPageCell.identifier)
        collectionView.delegate = menuatorViewDataController
        collectionView.dataSource = menuatorViewDataController
        collectionView.isPagingEnabled = true
        collectionView.allowsSelection = false
        
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.minimumLineSpacing = 0
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
