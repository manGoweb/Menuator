//
//  MenuatorDataController.swift
//  Menuator
//
//  Created by Aguele/Rafaj on 24/10/2017.
//  Copyright (c) 2017 Ford. All rights reserved.
//

import Foundation


class MenuatorDataController: NSObject {
    
    var previousX: CGFloat = 0.0
    var currentX: CGFloat = 0.0
    
    struct MenuItem {
        let text: String
        let configure: Menuator.ConfigureLabel?
        let action: Menuator.PerformAction
    }
    
    var menuItems: [MenuItem] = []
    var requestXUpdate: ((CGFloat)->())?
    var offsetChanged: ((_ offset: CGFloat)->())?
    var padding: (()->(CGFloat))?
    var leftMargin: (()->(CGFloat))?
    var rightMargin: (()->(CGFloat))?
    var didTapCell: ((_ indexPath: IndexPath, _ cellFrame: CGRect)->())?
    
}

// MARK: - UICollectionViewDelegate

extension MenuatorDataController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellFrame = collectionView.layoutAttributesForItem(at: indexPath)?.frame ?? CGRect()
        didTapCell?(indexPath, cellFrame)
    }
}

// MARK: - UICollectionViewDataSource

extension MenuatorDataController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuatorCollectionViewCell.identifier, for: indexPath) as? MenuatorCollectionViewCell else {
            fatalError("Cell not registered!")
        }
        cell.menuItem = menuItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

// MARK: - UICollectionViewDataSource

 extension MenuatorDataController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let diff = previousX - scrollView.contentOffset.x
        previousX = scrollView.contentOffset.x
        currentX += diff

        requestXUpdate?(currentX)
        
        offsetChanged?(scrollView.contentOffset.x)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuatorDataController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let menuItem = menuItems[indexPath.row]
        var label = UILabel()
        menuItem.configure?(&label)

        let width = (menuItem.text.width(usingFont: label.font) + 1)
        return CGSize(width: width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding = self.padding?() ?? 0
        let leftMargin = self.leftMargin?() ?? 0
        let rightMargin = self.rightMargin?() ?? 0
        return UIEdgeInsets(top: 0, left: (padding + leftMargin), bottom: 0, right: (padding + rightMargin))
    }
    
}
