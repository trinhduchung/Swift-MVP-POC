//
//  AutoMobileDetailViewController.swift
//  MVPPOC
//
//  Created by HungTD7 on 11/30/15.
//  Copyright © 2015 Hung. All rights reserved.
//

import Foundation
import UIKit

class AutoMobileDetailViewController: UIViewController {
    
    var autoMobileDetail: AutoMobileDetail?
    var presenter: AutoMobileDetailPresenter?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(autoMobileDetail: AutoMobileDetail) {
        self.init(nibName: nil, bundle: nil)
        self.autoMobileDetail = autoMobileDetail
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let autoMobileDetailView = AutoMobileDetailView.loadFromNibNamed(String(AutoMobileDetailView)) as! AutoMobileDetailView
        autoMobileDetailView.frame = self.view.frame
        self.view.addSubview(autoMobileDetailView)
        autoMobileDetailView.delegate = self
        
        self.presenter = AutoMobileDetailPresenter.init(model: self.autoMobileDetail!, view: autoMobileDetailView)
        self.presenter?.displayAutoMobileDetail()
    }
}

extension AutoMobileDetailViewController: AutoMobileDetailViewActionDelegate {
    func autoMobileDetailViewDidDeleteButtonPressed(autoMobileDetailView: AutoMobileDetailView) {
        self.presenter?.deleteAutoMobileDetail()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


