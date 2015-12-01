//
//  Automobile.swift
//  MVPPOC
//
//  Created by HungTD7 on 11/30/15.
//  Copyright © 2015 Hung. All rights reserved.
//

import Foundation
class AutoMobile: NSObject {
    var make:   String = ""
    var model:  String = ""
    var year:   String = ""
    
    override init() {
        super.init()
    }
    
    convenience init(make: String, model: String, year: String) {
        self.init()
        
        self.make = make
        self.model = model
        self.year = year
    }
}