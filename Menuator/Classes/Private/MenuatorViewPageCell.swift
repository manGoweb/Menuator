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
        willSet {
            guard let view = newValue else {
                return
            }
            contentView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }

}
