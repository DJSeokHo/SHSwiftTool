//
//  BasicGrammar.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 21/06/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation


class BasicGrammer {
    
    /*
     简单值
    */
    func simpleValue() {
        
        // let 是常量
        let name = "name"
        
        // var 是变量
        var age = 20
        age = 10
        
        // 指定类型
        let nameString: String = "name"
        let ageNumber: Int = 40
        
        // 类型转换
        let ageParsing: Int = Int(ageNumber)
        
        print("\(name) \(age) \(nameString) \(ageNumber) \(ageParsing)")
    }
    
    /*
     长字符串
    */
    func longString() {
        let name = "name"
        let age: Int = 20
        
        let string = """
        this is long long long string, name is \(name), age is \(age).
        this is long long long string, age is \(name), name is \(age).
        """
        print(string)
    }
    
    /*
     数组
    */
    func makeArray() {
        var shoppingList = ["1", "2", "name", "age"]
        print(shoppingList[1])
       
        shoppingList.append("haha")
        print(shoppingList[shoppingList.count - 1])
        
        // 新建一个空字符串
        var emptyArray = [String]()
        emptyArray.append("1")
        emptyArray.append("2")
        
        print(emptyArray[0])
    }
    
    /*
     字典
    */
    func makeDictionary() {
        
        var peopleDictionary = [
            "name": "haha",
            "age": "20",
        ]
        
        // 未强制解析 - 未强制拆包
        print(peopleDictionary["name"])
        
        
        var peopleAnyDictionary = [
            "name": "haha",
            "age": 20,
        ] as [String: Any]
        
        // 惊叹号是强制解析 - 强制拆包
        print(peopleAnyDictionary["age"]!)
        
        // 新建一个新的字典
        var emptyDictionary = [String: Any]()
        emptyDictionary["name"] = "hehe"
        emptyDictionary["age"] = 40
        
        print(emptyDictionary["name"]!)
    }
    
    
    /*
     switch控制 不需要 break
     因为swift 不存在条件贯穿
    */
    func switchControl() {
        let name = "haha"
        
        switch name {
            /*
             一个case块可以匹配多个值
            */
            case "haha", "gaga":
                print("haha or gaga")
            
            case "hehe":
                print("hehe")
            
            default:
                print("55555")
                break
        }
        
        switch name {
            /*
             一个case块可以匹配多个值
             */
            case "haha", "gaga":
                print("haha or gaga")
            
            case "hehe":
                print("hehe")
            
            case let failedMatchingResult:
                /*
                 都不匹配的情况，string的值就会赋值给failedMatchingResult
                 方便程序的结构化
                */
                print("\(failedMatchingResult) no matching")
      
        }
    }
    
    /*
     for循环控制流
    */
    func forControl() {
       
        let numberArray = [2, 3, 7, 8, 6]
        
        for number in numberArray {
            print(number)
        }
        print("-------------------------")
        /* 0..5 0到5， 0..<5 0到4 */
        for i in 0..<numberArray.count {
            print(numberArray[i])
        }
        
    }
    
    /*
     while循环控制流
    */
    func whileControl() {
        let numberArray = [2, 3, 7, 8, 6]
        
        var i = 0
        while i < numberArray.count {
            print(numberArray[i])
            i += 1
        }
        
        print("-------------------------")
        
        var n = 0
        repeat {
            print(numberArray[n])
            n += 1
        } while n < numberArray.count
    }
    
    /*
     带返回函数
     */
    func functionWithReturn(name: String) -> String {
        return "name is \(name)"
    }
    
    /*
     返回元组
    */
    func functionWithReturnTuple(name: String, age: Int) -> (name: String, age: Int) {
        return (name, age)
    }
    
    /*
     嵌套函数
    */
    func functionInFunction() {
        var x = 5
        func add() {
            x += 5
        }
        
        add()
        
        print(x)
    }
    
    /*
     函数返回一个函数
    */
    func functionReturnFunction() -> ((Int) -> String) {
        
        func getAgeString(age: Int) -> String {
            
            return "age is \(age)"
        }
        
        return getAgeString
    }
    
    /*
     函数作为一个参数
    */
    func functionWithFunctionParameter(name: String, helloFunction: ((String) -> String)) {
        
        let helloString = helloFunction(name)
        print(helloString)
    }
    func helloFunction(name: String) -> String {
        return "hello \(name)"
    }
    
    /*
     类
    */
    func createAClass() {
        let shape = Shape(name: "???", age: 20)
        shape.numberOfSides = 7
        
        let shapeDescription = shape.simpleDescription()
        print(shapeDescription)
    }
    
    /*
     枚举
    */
    func testEnum() {
        let ace = Rank.ace
        let aceRawValue = ace.rawValue
        print(aceRawValue)
    }
    
    /*
     结构体
    */
    func testStruct() {
        let card = Card(rank: Rank.three)
        print(card.simpleDescription())
    }
    
    /*
     扩展
    */
    func testExtension() {
        print(6.simpleDescription)
    }
    
    /*
     值解析
    */
    func valueParsing() {
        let str: String! = "haha"
        
        if let temp = str {
            print("\(temp)")
        }
        else {
            print("str is nil")
        }
        
        var s: String? = nil
        
        s = "heihei"
        
        if let t = s {
            print("\(t)")
        }
        else {
            print("s is nil")
        }
    }
    
    func checkPlateformAPI() {
        
        if #available(iOS 9, OSX 10.11, *) {
            print("new API")
        }
        else {
            print("old API")
        }
    }
    
}
