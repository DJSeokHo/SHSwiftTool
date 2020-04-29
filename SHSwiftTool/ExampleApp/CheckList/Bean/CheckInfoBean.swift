//
//  CheckInfoBean.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/27.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation

class CheckInfoBean: IBean {
    
    public var uuid: String
    public var content: String
    public var dateTime: String
    public var  done: String
    
    init(uuid: String, content: String, dateTime: String, done: String) {
        self.uuid = uuid
        self.content = content
        self.dateTime = dateTime
        self.done = done
    }
 
    func getId() -> String {
        return self.uuid
    }
    
    func toString() -> String {
        return uuid + " " + content + " " + dateTime + " " + done
    }
    
}
