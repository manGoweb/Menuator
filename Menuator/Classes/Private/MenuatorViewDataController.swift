//
//  MenuatorViewDataController.swift
//  Menuator
//
//  Created by Aguele/Rafaj on 01/11/2017.
//  Copyright (c) 2017 Ford. All rights reserved.
//

import Foundation
import UIKit


class MenuatorViewDataController: NSObject {
    
    public let menuator: Menuator
    
    init(menuator: Menuator) {
        self.menuator = menuator
    }
    
}


extension MenuatorViewDataController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuator.menuatorController.menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuatorViewPageCell.identifier, for: indexPath) as! MenuatorViewPageCell
        let menuatorView = collectionView.superview as! MenuatorView
        let pageView = menuatorView.dataSource?.page(index: indexPath.item, menuatorView: menuatorView)
        if cell.pageView?.superview != nil {
            cell.pageView!.removeFromSuperview()
        }
        cell.pageView = pageView
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: Scroll view delegate methods
    
    func calculate(_ scrollView: UIScrollView) {
        let pageIndex: Int = Int(floor(scrollView.contentOffset.x / scrollView.frame.size.width))
        if pageIndex != menuator.currentIndex && pageIndex >= 0 {
            menuator.collectionView.scrollToItem(at: IndexPath(item: pageIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            menuator.currentIndex = pageIndex
            
            guard let menuatorView = scrollView.superview as? MenuatorView else {
                return
            }
            menuatorView.delegate?.didScrollTo(index: pageIndex, menuatorView: menuatorView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        calculate(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            calculate(scrollView)
        }
    }
    
}










