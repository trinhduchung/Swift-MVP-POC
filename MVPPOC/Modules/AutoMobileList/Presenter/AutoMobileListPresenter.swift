//
//  AutoMobileListPresenter.swift
//  MVPPOC
//
//  Created by HungTD7 on 11/30/15.
//  Copyright © 2015 Hung. All rights reserved.
//

import Foundation

class AutoMobileListPresenter: NSObject {
    
    var model: AutoMobileListProtocol = AutoMobileList()
    var view: AutoMobileListViewProtocol = AutoMobileListViewController()
    
    override init() {
        super.init()
    }
    
    convenience init(model: AutoMobileListProtocol, view: AutoMobileListViewProtocol) {
        self.init()
        
        self.model = model
        self.view = view
    }
    
    static func bind(model: AutoMobileListProtocol, view: AutoMobileListViewProtocol) -> AutoMobileListPresenter {
        return AutoMobileListPresenter.init(model: model, view: view)
    }
    
    func displayViewFromAutoMobileList() {
        self.view.displayAutoMobiles(self.model.loadAutoMobiles())
    }
}