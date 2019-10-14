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
    
    /*
     可变字符串
     */
    public func testNSMutableString() {
        
        let name = "seok ho"
        let str = NSMutableString(string: name)
        
        str.append(" haha")
        print(str)
        
        str.insert("you ", at: 0)
        print(str)
        
        str.deleteCharacters(in: NSMakeRange(0, 3))
        print(str)
        
        str.replaceCharacters(in: NSMakeRange(0, 1), with: "kk")
        print(str)
        
        var str1 = NSMutableString(string: name)
        str1 = str1.appending(" hehe") as! NSMutableString
        print(str1)
        
    }
    
    /*
     日期与时间
     */
    public func testNSDate() {
        
        let date1 = NSDate()
        print(date1)
        
        /* 一天之后 */
        let date2 = NSDate(timeIntervalSinceNow: 3600 * 24)
        print(date2)
        
        /* 三天之前 */
        let date3 = NSDate(timeIntervalSinceNow: -3 * 3600 * 24)
        print(date3)
        
        /* 1970的20年后 */
        let date4 = NSDate(timeIntervalSince1970: 3600 * 24 * 366 * 20)
        print(date4)
        
        /* 获取当前地区的日期描述 */
        let cn = NSLocale.current
        print(date1.description(with: cn))
        
        /* 日期比较 */
        let earlier = date1.earlierDate(date2 as Date)
        print(earlier)
        
        let later = date1.laterDate(date2 as Date)
        print(later)
        
        switch date1.compare(date3 as Date) {
            
            case .orderedAscending:
                print("date1 在 date3 之前")
            
            case .orderedSame:
                print("date1 和 date3 相同")
            
            case .orderedDescending:
                print("date1 在 date3 之后")
        
        }
        
        print("date1 和 date3 之间差 \(date1.timeIntervalSince(date3 as Date)) 秒")
        print("date2 和 现在差 \(date1.timeIntervalSinceNow) 秒")
    }
    
    /*
     日期格式器
     */
    public func testNSDateFormatter() {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = df.string(from: Date())
        print(dateString)
    }
    
    /*
     日历和日期组件
     */
    public func testNSCalendarAndNSDateComponents() {
        
        /* 获取日期的各部分 */
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        let date = Date()
        
        let unitFlag: NSCalendar.Unit = [
            NSCalendar.Unit.year,
            NSCalendar.Unit.month,
            NSCalendar.Unit.day,
            NSCalendar.Unit.hour,
            NSCalendar.Unit.minute,
            NSCalendar.Unit.second,
            NSCalendar.Unit.weekday
        ]
        
        let comp = calendar!.components(unitFlag, from: date)
        print(comp.year!)
        print(comp.month!)
        print(comp.day!)
        print(comp.hour!)
        print(comp.minute!)
        print(comp.second!)
        print(comp.weekday!)
        
        
        /* 生成日期 */
        let comp1 = NSDateComponents()
        comp1.year = 2013
        comp1.month = 3
        comp1.day = 5
        comp1.hour = 18
        comp1.minute = 30
        comp1.second = 30
        
        let date1 = calendar!.date(from: comp1 as DateComponents)
        print(date1!)
    }
}
