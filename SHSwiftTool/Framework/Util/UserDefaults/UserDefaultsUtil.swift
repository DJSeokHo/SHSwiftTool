//
//  UserDefaultsUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 18/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class UserDefaultsUtil {
    
    public static func save(key: String, andValue value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    public static func save(key: String, andValue value: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    public static func get(key: String) -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key) ?? ""
    }
    
    public static func get(key: String) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key) 
    }
    
}
