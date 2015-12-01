//
//  AutoMobileDetailPresenter.swift
//  MVPPOC
//
//  Created by HungTD7 on 11/30/15.
//  Copyright © 2015 Hung. All rights reserved.
//

import Foundation

class AutoMobileDetailPresenter: NSObject {
    
    var model: AutoMobileDetailProtocol = AutoMobileDetail()
    var view: AutoMobileDetailViewProtocol = AutoMobileDetailView()
    
    override init() {
        super.init()
    }
    
    convenience init(model: AutoMobileDetailProtocol, view: AutoMobileDetailViewProtocol) {
        self.init()
        self.model = model
        self.view = view
    }
    
    static func bind(model: AutoMobileDetailProtocol, view: AutoMobileDetailViewProtocol) -> AutoMobileDetailPresenter {
        return AutoMobileDetailPresenter.init(model: model, view: view)
    }
    
    func displayAutoMobileDetail() {
        self.view.displayAutoMobile(self.model.loadAutoMobile())
    }
    
    func deleteAutoMobileDetail() {
        self.model.deleteAutomobile()
    }
}