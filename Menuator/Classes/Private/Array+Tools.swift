//
//  Array+Tools.swift
//  Menuator
//
//  Created by Vlad Radu & Ondrej Rafaj on 14/12/2017.
//  Copyright © 2017 manGoweb UK. All rights reserved.
//

import Foundation


extension Array {

    func safe(index: Int) -> Int? {
        guard !isEmpty, index >= 0, index < count else {
            return nil
        }
        return index
    }

    func guaranteed(index: Int) -> Int {
        if index < 0 {
            return 0
        } else if index >= count {
            return endIndex - 1
        }
        return index
    }

}
