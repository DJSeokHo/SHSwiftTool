//
//  DateUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/25.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation

class DateUtil {
    public static func getCurrentDateTimeStringWithStandardSQLiteDateTimeFromatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}
