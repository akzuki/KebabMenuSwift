//
//  Setting.swift
//  KebabMenuSwift
//
//  Created by Hai Phan on 8/18/16.
//  Copyright © 2016 Hai Phan. All rights reserved.
//

import Foundation

struct Menu {
    var menuImage: String!
    var menuLabel: String!
    
    init() {}
    
    init(menuImage: String, menuLabel: String) {
        self.menuImage = menuImage
        self.menuLabel = menuLabel
    }
}