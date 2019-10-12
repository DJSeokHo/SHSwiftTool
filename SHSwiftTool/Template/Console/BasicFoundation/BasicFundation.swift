//
//  BasicFundation.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 12/10/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

/*
 NSInteger, NSUInteger, CGFloat 这三个不是包装类
 */
class BasicFoundation {
    
    public static let TAG: String = "BasicFoundation"
    
    
    /*
     包装类，把值类型包装成对象
     NSValue, NSNumber
     可以用来包装单个 short, int, long, float, char, 指针, 对象 id
     包装后就可以把这些值类型 添加到 NSArray, NSSet等集合，因为这些集合的元素只能是对象
     
     包装类，NSValue 是 NSNumber的父类
     
     NSString, NSMutableString
     Swift内置了一个String结构体， let声明时不可变，var声明时可变
     String可以调用NSString的全部API。
     */
    public func packageClass() {
        
        // 将Int类的值包装成 NSNumber对象
        let numInt: NSNumber = NSNumber(value: 20)
        print(numInt.intValue)
        
        // 将Double类型的值包装成NSNumber对象
        let numDouble: NSNumber = NSNumber(value: 3.5)
        print(numDouble.doubleValue)
        
    }
    
    /*
     NSString, NSMutableString
     Swift内置了一个String结构体， let声明时不可变，var声明时可变
     String可以调用NSString的全部API。
     */
    public func testNSString() {
       
        let hello: NSString = "hello"
        print(hello)
        
        let name: NSString = "Seok Ho"
        
        var str: NSString = "hello"
        
        str = str.appending(name as String) as NSString
        
        print(str.length)
        
        let start: NSString = str.substring(to: 3) as NSString
        print(start)
        
        let end: NSString = str.substring(from: 3) as NSString
        print(end)
        
        let between: NSString = str.substring(with: NSMakeRange(2, 4)) as NSString
        print(between)
        
        let range = str.range(of: "Seok")
        print("\(range.location) \(range.length)")
        
        print(str.uppercased)
        print(str.lowercased)
    }
    
}
