//
//  ArrayDataSource.swift
//  MVPPOC
//
//  Created by HungTD7 on 11/30/15.
//  Copyright © 2015 Hung. All rights reserved.
//

import Foundation
import UIKit

typealias CellBlock = (cell: NSObject, item: NSObject) -> Void

class ArrayDataSource: NSObject {
    
    private
    var items: NSArray = Array<NSObject>()
    var cellIdentifier: String! = ""
    var configureCellBlock: CellBlock?
    var cellSelectionBlock: CellBlock?
    
    override init() {
        super.init()
    }
    
    convenience init(items: Array<NSObject>, cellIdentifier: String, configureCellBlock: CellBlock, cellSelectionBlock: CellBlock) {
        self.init()
        
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureCellBlock
        self.cellSelectionBlock = cellSelectionBlock
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> NSObject {
        return self.items.objectAtIndex(indexPath.row) as! NSObject
    }
}

extension ArrayDataSource: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        let item = self.itemAtIndexPath(indexPath)
        if (self.cellSelectionBlock != nil) {
            self.cellSelectionBlock!(cell: cell, item: item)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.itemAtIndexPath(indexPath)
        if (self.configureCellBlock != nil) {
            self.configureCellBlock!(cell: cell, item: item)
        }
    }
}

extension ArrayDataSource: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath)
        //Don’t perform data binding at this point, because there’s no cell on screen yet. For this you can use tableView:willDisplayCell:forRowAtIndexPath: method which can be implemented in the delegate of UITableView. The method called exactly before showing cell in UITableView’s bounds.
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}



