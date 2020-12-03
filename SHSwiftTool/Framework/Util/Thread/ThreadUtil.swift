//
//  ThreadUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 17/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class ThreadUtil {
    
    public static func startThread(runnable: @escaping () -> Void) {
        DispatchQueue.global().async {
            runnable()
        }
    }
    
    public static func startUIThread(runnable: @escaping () -> Void, afterSeconds seconds: Double) {
        
        Thread.sleep(forTimeInterval: seconds)
        
        DispatchQueue.main.async {
            runnable()
        }
    }
    
}
