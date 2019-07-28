//
//  BasicFunction.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 23/06/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class BasicFunction {
    
    func hello(name: String) -> String {
        return "Hello \(name)"
    }
    
    func returnWithMultiItemTuple() -> (name: String, age: Int) {
        return ("Seok Ho", 32)
    }
    
    /*
        from 在这里就是函数参数标签
        参数标签的使用能够让一个函数在调用时更有表达力，更类似自然语言，并且仍保持了函数内部的可读性以及清晰的意图
    */
    func functionWithParameterTag(person: String, from hometown: String) -> String {
        return "Hello \(person) welcome and WOW, you come from \(hometown)!!!"
    }
    
    /*
        和python一样，指定了参数默认值的函数就可以在调用时忽略该参数值
    */
    func functionWithDefaultValue(_ persion: String, hwoold age: Int = 30) {
        print("name is \(persion) and age is \(age)")
    }
    
    /*
        可变参数
    */
    func functionChangeParameter(numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    /*
     函数作为参数传递给另一个函数
     把一个函数作为参数，这个函数用()表示
     然后((Int) -> Int) 函数里用(Int)表示这个函数接受一个Int
     然后 -> Int 表示这个函数返回一个Int
    */
    func functionWithFunctionParameter(data: Int, function: ((Int) -> Int)) -> Int {
        let result = function(data)
        return result
    }
    func square(data: Int) -> Int {
        return data * data
    }
    func cube(data: Int) -> Int {
        return data * data * data
    }
    
    /*
     函数返回另一个函数
    */
    func functionReturnFunction(type: String) -> ((String) -> String) {
        switch type {
        case "haha":
            return self.hahaFunction(name:)
        case "hehe":
            return self.heheFunction(name:)
        default:
            return self.hahaFunction(name:)
        }
    }
    private func hahaFunction(name: String) -> String {
        return "haha \(name)"
    }
    private func heheFunction(name: String) -> String {
        return "hehe \(name)"
    }
    
    /*
     函数返回另一个函数
     采用闭包形式
     闭包类似于objective-c 中的代码块,Java中的lambda
     
     闭包：
     {
        (parameter: String) -> String in
            return result
     }
     
     {
         (参数) -> 返回 in
            可执行代码部分
     }
     
     闭包的本质是功能灵活的代码块
    */
    func functionReturnFunctionByClosure(type: String) -> ((String) -> String) {
        switch type {
        case "haha":
            return {
                (name: String) -> String in
                    return "haha \(name)"
            }
        case "hehe":
            return {
                (name: String) -> String in
                    return "hehe \(name)"
            }
        default:
            return {
                (name: String) -> String in
                return "haha \(name)"
            }
        }
    }
    
    /*
     函数返回另一个函数
     采用闭包形式
     闭包类似于objective-c 中的代码块,Java中的lambda
     
     闭包：
     {
     (parameter: String) -> String in
     return result
     }
     
     {
     (参数) -> 返回 in
     可执行代码部分
     }
     
     闭包的本质是功能灵活的代码块
     */
    func closureTest() {
        let someClosureFunction = {
            (numberOne: Int, numberTwo: Int) -> Int in
                return numberOne + numberTwo
        }
        
        print(someClosureFunction(1, 2))
    }
   
}
