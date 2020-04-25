//
//  UUIDUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/25.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation

class UUIDUtil {
    
    public static func getUUID() -> String {
        return NSUUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
    
}
