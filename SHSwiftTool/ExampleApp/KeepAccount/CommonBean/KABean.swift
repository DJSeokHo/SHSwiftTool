//
//  KABean.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation

protocol KABean {
    
    func toString() -> String
    
    func getUUID() -> String
    
    func getTitle() -> String
    
    func getCategory() -> String
    
    func getAmount() -> Float
    
    func getContent() -> String
    
    func getDateTime() -> String
    
    func getImageUrl() -> String
    
    func getLatitude() -> Float
    
    func getLongitude() -> Float
}
