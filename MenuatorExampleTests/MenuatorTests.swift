//
//  MenuatorTests.swift
//  Menuator_Tests
//
//  Created by Aguele/Rafaj on 26/10/2017.
//  Copyright © 2017 Ford. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
import SpecTools
@testable import Menuator
@testable import MenuatorExample

// TODO: add tests for insert and remove methods
class MenuatorTests: QuickSpec {
    
    override func spec() {
        describe("ViewController with Menuator") {
            var subject: ViewController!
            var menuator: Menuator!
            var menuatorView: MenuatorView!
            var collectionView: UICollectionView!
            
            beforeEach {
                subject = ViewController()
                subject.spec.prepare.simulatePresentViewController()
                subject.spec.prepare.set(viewSize: .iPhone6)
                
                menuator = subject.menuator
                menuatorView = subject.menuatorView
                collectionView = menuator.spec.find.all(elementsOfType: UICollectionView.self, visualize: .none)!.first
            }
            
            it("should have the right number of sections") {
                expect(collectionView.numberOfSections).to(equal(1))
            }
            
            it("should have the right number of items") {
                expect(collectionView.numberOfItems(inSection: 0)).to(equal(26))
            }
            
            it("should set the right label properties") {
                let label = collectionView.spec.find.first(labelWithText: "dolor")!
                
                expect(label.font).to(equal(UIFont.systemFont(ofSize: 16)))
                expect(label.textAlignment).to(equal(NSTextAlignment.center))
                expect(label.textColor).to(equal(UIColor.white))
                expect(label.spec.check.isVisible(on: subject.view)).to(beTrue())
            }
            
            it("should have the right height for floatView when set") {
                expect(menuator.floatView.frame.size.height).to(equal(4))
            }
            
            it("should have the right color for floatView when set") {
                expect(menuator.floatView.backgroundColor).to(equal(UIColor.white))
            }
            
            it("should have the right height for lineView when set") {
                expect(menuator.lineView.frame.size.height).to(equal(2))
            }
            
            it("should have the right color for lineView when set") {
                expect(menuator.lineView.backgroundColor).to(equal(UIColor.gray))
            }
            
            it("should have the right size for rounded corners when set") {
                expect(menuator.floatView.layer.cornerRadius).to(equal(1))
            }
            
            describe("when cell is tapped") {
                beforeEach {
                    collectionView.spec.action.tap(item: 0).tap(item: 2)
                }

                it("should execute action on an element") {
                    expect(subject.tapCounter).to(equal(2))
                }
            }

            describe("when cell is added") {
                beforeEach {
                    subject.add()
                }

                it("should have the right number of items") {
                    expect(collectionView.numberOfItems(inSection: 0)).to(equal(27))
                }
            }

            describe("when cell is removed") {
                beforeEach {
                    subject.remove()
                }

                it("should have the right number of items") {
                    expect(collectionView.numberOfItems(inSection: 0)).to(equal(25))
                }
            }

            describe("MenuatorView") {
                var label:  UILabel!
                
                beforeEach {
                    label = menuatorView.dataSource?.page(index: 6, menuatorView: menuatorView) as! UILabel
                    menuatorView.collectionView.scrollToItem(at: IndexPath(item: 5, section: 0), at: .centeredHorizontally, animated: false)
                    menuatorView.collectionView.delegate?.scrollViewDidEndDecelerating!(menuatorView.collectionView)
                }
                
                it("should have delegate and data source (and menuator)") {
                    expect(menuatorView.delegate).toNot(beNil())
                    expect(menuatorView.dataSource).toNot(beNil())
                    expect(menuatorView.menuatorViewDataController.menuator).toNot(beNil())
                }
                
                it("should have the right number of screens") {
                    expect(menuatorView.collectionView.numberOfItems(inSection: 0)).to(equal(26))
                }
                
                it("should add menuator view as subview") {
                    expect(subject.view.subviews.contains(menuatorView)).to(beTrue())
                }
                
                it("menuatorView should be the same size as menuator") {
                    expect(menuatorView.bounds).to(equal(subject.view.bounds))
                }
                
                it("should return the right view when page index is called") {
                    expect(label.text).to(equal("adipiscing"))
                }
                
                it("should scroll to page when menu item is tapped") {
                    expect(subject.data.currentPage).to(equal(5))
                }
            }
        }
    }
}


