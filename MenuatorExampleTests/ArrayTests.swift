//
//  ArrayTests.swift
//  MenuatorExampleTests
//
//  Created by DevPair9 on 15/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Menuator
@testable import MenuatorExample


class ArrayTests: QuickSpec {

    override func spec() {

        let array = [1, 2, 3, 4, 5]

        describe("Testing guaranteed(index:) method") {
            context("checking guaranteed index is correct in all situations") {
                it("should return the last index when index is greater than count") {
                    let guaranteedIndex = array.guaranteed(index: 6)
                    expect(guaranteedIndex) == 4
                }

                it("should return 0 when index is less than zero") {
                    let guaranteedIndex = array.guaranteed(index: -3)
                    expect(guaranteedIndex) == 0
                }

                it("should return the index whe it's valid") {
                    let guaranteedIndex = array.guaranteed(index: 2)
                    expect(guaranteedIndex) == 2
                }
            }
        }

        describe("Testing safe(index:) method") {
            context("checking safe index is correct in all situatiuons") {
                it("should return nil when index is greater than count") {
                    let safeIndex = array.safe(index: 6)
                    expect(safeIndex).to(beNil())
                }

                it("should return nil when index is less than zero") {
                    let safeIndex = array.safe(index: -3)
                    expect(safeIndex).to(beNil())
                }

                it("should return the index when it is correct") {
                    let safeIndex = array.safe(index: 2)
                    expect(safeIndex) == 2
                }
            }
        }
    }
}
