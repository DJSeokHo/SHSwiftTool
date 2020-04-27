//
//  NotificationUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 18/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class NotificationUtil {
    
    public static func post(name: String, object: Any, userInfo: Dictionary<AnyHashable, Any>) {
      
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object, userInfo: userInfo)
}
    
    public static func addObserver(observer: Any, selector: Selector, name: String) {
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(rawValue: name), object: nil)
        
    }
    
    public static func removeAllObserver(observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}
