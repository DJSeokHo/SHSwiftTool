//
//  KeepAccountInfoBean.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation

class KeepAccountInfoBean: KABean {
    
    public var uuid: String!
    public var title: String!
    public var category: String!
    public var amount: Float!
    public var content: String!
    public var dateTime: String!
    public var imageUrl: String!
    public var latitude: Float!
    public var longitude: Float!
    
    func toString() -> String {
        return "\(uuid ?? "") \(title ?? "") \(category ?? "") \(amount ?? 0) \(content ?? "") \(dateTime ?? "") \(imageUrl ?? "") \(latitude ?? 0) \(longitude ?? 0)"
    }
    
    func getUUID() -> String {
        return uuid
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getCategory() -> String {
        return category
    }
    
    func getAmount() -> Float {
        return amount
    }
    
    func getContent() -> String {
        return content
    }
    
    func getDateTime() -> String {
        return dateTime
    }
    
    func getImageUrl() -> String {
        return imageUrl
    }
    
    func getLatitude() -> Float {
        return latitude
    }
    
    func getLongitude() -> Float {
        return longitude
    }
    
}
