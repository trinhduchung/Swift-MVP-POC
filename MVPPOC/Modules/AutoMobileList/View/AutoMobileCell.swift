//
//  AutoMobileCell.swift
//  MVPPOC
//
//  Created by HungTD7 on 11/30/15.
//  Copyright © 2015 Hung. All rights reserved.
//

import Foundation
import UIKit

class AutoMobileCell: UITableViewCell {
    
    static func nib() -> UINib {
        return UINib(nibName: String(AutoMobileCell.self), bundle: nil)
    }
    
    func updateCell(cellTitle: String, yearSubtitle: String) {
        self.textLabel?.text = cellTitle
        self.detailTextLabel?.text = yearSubtitle
    }
}