//
//  FordMenuCollectionViewCell.swift
//  Menuator
//
//  Created by Aguele/Rafaj on 05/09/2017.
//  Copyright (c) 2017 Ford. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class MenuatorCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "FordMenuCollectionViewCell"
    var label = UILabel()
    var menuItem: MenuatorDataController.MenuItem? {
        didSet {
            label.text = menuItem?.text
            menuItem?.configure?(&label)
        }
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}











