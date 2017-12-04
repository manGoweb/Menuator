//
//  MenuatorViewPageCell.swift
//  Menuator
//
//  Created by Aguele/Rafaj on 01/11/2017.
//  Copyright (c) 2017 Ford. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class MenuatorViewPageCell: UICollectionViewCell {
    
    static let identifier: String = "MenuatorViewPageCell.identifier"
    
    var pageView: UIView? {
        didSet {
            guard let pageView = pageView else {
                return
            }
            
            contentView.addSubview(pageView)
            pageView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    
}
