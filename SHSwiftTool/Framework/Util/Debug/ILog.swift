//
//  ILog.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 03/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class ILog {
    
    public static func debug(tag: String, content: Any) {
        print("ILog ======> \(tag): \(content)")
    }
    
}
