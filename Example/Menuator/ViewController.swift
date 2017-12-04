//
//  ViewController.swift
//  Menuator
//
//  Created by Aguele/Rafaj on 09/05/2017.
//  Copyright (c) 2017 Ford. All rights reserved.
//

import UIKit
import Menuator
import SnapKit


public class ViewController: UIViewController {
    
    public var data = Data()
    public let menuator = Menuator(leftMargin: 86)
    public var menuatorView: MenuatorView!
    public var leftElement: UIView = UIView()
    
    public let menuatorTopPadding: CGFloat = 150
    public let menuatorHeight: CGFloat = 46
    
    var tapCounter: Int = 0
    
    
    // MARK: Configure elements
    
    func configureMenuatorWithAllItems() {
        for string in data.items {
            menuator.add(menuItem: string, configure: { label in
                label.font = UIFont.systemFont(ofSize: 16)
                label.textAlignment = .center
                label.textColor = .white
            }, didBecomeActive: {
                self.tapCounter += 1
                print("Tapped \(string); Tap no.: \(self.tapCounter)")
            })
        }
        
        menuator.floatViewHeight = 4
        menuator.floatViewColor = .white
        menuator.lineViewHeight = 2
        menuator.lineViewColor = .gray
        menuator.roundedCorners = true
        menuator.itemPadding = 0
        
        menuator.offsetChanged = { x in
            var scaleValue: CGFloat = (1 - (x / (self.menuator.leftMargin - 30)))
            if scaleValue > 1 {
                scaleValue = 1
            }
            if scaleValue < 0 {
                scaleValue = 0
            }
            
            let transformation: CGAffineTransform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
            self.leftElement.transform = transformation
        }
    }
    
    func configureOptionalMenuatorContentView() {
        menuatorView = MenuatorView(menuator: menuator)
        menuatorView.delegate = self
        menuatorView.dataSource = self
    }
    
    // MARK: View lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 66.0/255.0, green: 89.0/255.0, blue: 104.0/255.0, alpha: 1)
        
        configureOptionalMenuatorContentView()
        configureMenuatorWithAllItems()
        
        configureLayout()
    }
    
}

// MARK: - Menuator content view delegate & data source methods

extension ViewController: MenuatorViewDelegate, MenuatorViewDataSource {

    public func page(index: Int, menuatorView: MenuatorView) -> UIView {
        return data.pages[index]
    }

    public func didScrollTo(index: Int, menuatorView: MenuatorView) {
        print("Scrolled manually to: \(index)")
        data.currentPage = index
    }
}

// MARK: - Data

public struct Data {
    
    let items = ["Lorem", "ipsum", "dolor", "sit", "amet,", "consectetur", "adipiscing", "elit.", "Vestibulum", "tincidunt", "pellentesque", "hendrerit.", "Suspendisse", "eget", "enim", "non", "orci", "ornare", "Jonathan", "and", "his", "best", "buddy", "Ondrej", "rock!", "yeah"]
    
    var pages: [UIView] = []
    var currentPage: Int = 0
    
    init() {
        for s in items {
            let label = UILabel()
            label.text = s
            label.backgroundColor = .random
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 22)
            pages.append(label)
        }
    }
    
}

// MARK: - Demo helper methods

extension ViewController {
    
    func configureLayout() {
        view.addSubview(menuatorView)
        view.addSubview(leftElement)
        view.addSubview(menuator)
        
        leftElement.backgroundColor = .orange
        leftElement.layer.cornerRadius = (menuatorHeight / 2.0)
        leftElement.snp.makeConstraints { (make) in
            make.width.height.equalTo(menuatorHeight)
            make.left.equalTo(20)
            make.top.equalTo(menuator.snp.top)
        }
        
        menuatorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        menuator.snp.makeConstraints { (make) in
            make.top.equalTo(menuatorTopPadding)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(menuatorHeight)
        }
    }
    
}

