//
//  String+Tools.swift
//  Menuator
//
//  Created by Aguele/Rafaj on 24/10/2017.
//  Copyright (c) 2017 Ford. All rights reserved.
//

import Foundation


extension String {
    
    func width(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func height(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}
