//
//  AutoMobileListViewController.swift
//  MVPPOC
//
//  Created by HungTD7 on 11/30/15.
//  Copyright © 2015 Hung. All rights reserved.
//

import Foundation
import UIKit

class AutoMobileListViewController: UITableViewController {
    
    var presenter: AutoMobileListPresenter?
    var tableViewDataSource: ArrayDataSource?
    
    override func viewDidLoad() {
        self.presenter = AutoMobileListPresenter.init(model: AutoMobileList(), view: self)
    }

    override func viewDidAppear(animated: Bool) {
        self.presenter?.displayViewFromAutoMobileList()
    }
}

extension AutoMobileListViewController {
    func didSelectAutoMobile(autoMobile: AutoMobile) {
        let autoMobileDetail: AutoMobileDetail = AutoMobileDetail(autoMobile: autoMobile, autoMobileList: (self.presenter?.model as? AutoMobileList)!)
        let autoMobileDetailVC = AutoMobileDetailViewController(autoMobileDetail: autoMobileDetail)
        
        self.presentViewController(autoMobileDetailVC, animated: true, completion: nil)
    }

}

//View-ViewController go together
extension AutoMobileListViewController: AutoMobileListViewProtocol {
    
    func displayAutoMobiles(autoMobiles: NSArray) {
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.registerNib(AutoMobileCell.nib(), forCellReuseIdentifier: "autoMobileCell")
        let arrayDataSource = ArrayDataSource(items: autoMobiles as! Array<NSObject>, cellIdentifier: "autoMobileCell", configureCellBlock: { (cell , item) -> Void in
            if let autoMobileCell = cell as? AutoMobileCell {
                if let autoMobile = item as? AutoMobile {
                    autoMobileCell.updateCell(String(format: "%@ %@", autoMobile.make, autoMobile.model), yearSubtitle: autoMobile.year)
                }
            }
            }) { (cell, item) -> Void in
                if let autoMobile = item as? AutoMobile {
                    self.didSelectAutoMobile(autoMobile)
                }
        }
        
        self.tableViewDataSource    = arrayDataSource
        self.tableView.delegate     = arrayDataSource
        self.tableView.dataSource   = arrayDataSource
        self.tableView.reloadData()
    }
}


