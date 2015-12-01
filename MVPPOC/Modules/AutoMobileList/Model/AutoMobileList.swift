//
//  AutoMobileList.swift
//  MVPPOC
//
//  Created by HungTD7 on 11/30/15.
//  Copyright © 2015 Hung. All rights reserved.
//

import Foundation

enum AutoMobileListUpdatingStatus {
    case AutoMobileListUpdatingStatusIdle
    case AutoMobileListUpdatingStatusLoading
    case AutoMobileListUpdatingStatusDeleting
}

typealias LoadAutoMobileSuccess = () -> Void
typealias LoadAutoMobileFailure = (error: NSError) -> Void

class AutoMobileList: NSObject {
    
    private(set) var automobileList = [AutoMobile]()
    private(set) var updatingStatus = AutoMobileListUpdatingStatus.AutoMobileListUpdatingStatusIdle as AutoMobileListUpdatingStatus
    
    override init() {
        super.init()
    }
    
    func loadAutoMobile(success: LoadAutoMobileSuccess?, failure: LoadAutoMobileFailure?) {
        if (self.updatingStatus == AutoMobileListUpdatingStatus.AutoMobileListUpdatingStatusIdle) {
            self.updatingStatus = .AutoMobileListUpdatingStatusLoading
            
            AutoMobileLoader.loadListOfAutoMobiles({ (autoMobiles) -> Void in
                self.automobileList = autoMobiles
                self.updatingStatus = AutoMobileListUpdatingStatus.AutoMobileListUpdatingStatusIdle
                
                success?()
                
                }, failure: { (error) -> Void in
                    self.updatingStatus = .AutoMobileListUpdatingStatusIdle
                    
                    failure?(error: error)
            })
        }
    }
    
}

extension AutoMobileList: AutoMobileListProtocol {
    
    func removeAutoMobile(autoMobile: AutoMobile) {
        if (self.updatingStatus == AutoMobileListUpdatingStatus.AutoMobileListUpdatingStatusIdle) {
            self.updatingStatus = .AutoMobileListUpdatingStatusDeleting
            
            if (self.automobileList.contains(autoMobile)) {
                let tempArray = NSMutableArray(array: self.automobileList) as NSMutableArray
                tempArray.removeObject(autoMobile)
                
                self.automobileList = Array(tempArray) as! [AutoMobile]
                
                self.updatingStatus = .AutoMobileListUpdatingStatusIdle
            }
        }
    }
    
    func loadAutoMobiles() -> NSArray {
        
        if (self.automobileList.count > 0) {
            return self.automobileList;
        }
        
        let semaphore = dispatch_semaphore_create(0) as dispatch_semaphore_t
        
        self.loadAutoMobile({ () -> Void in
            dispatch_semaphore_signal(semaphore)
            }) { (error) -> Void in
                dispatch_semaphore_signal(semaphore)
        }
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)

        return self.automobileList;
    }
}



