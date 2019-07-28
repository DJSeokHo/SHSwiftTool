//
//  Person.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 28/07/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class Person {
    var name: String = ""
    var age: Int = 0
    
    /* 带属性观察者的属性 */
    var fullName: String = "" {
        
        willSet(newValue) {
            print("before set fullName to \(newValue)")
            self.fullName = newValue
        }
        
        didSet {
            print("after set fullName is \(self.fullName)")
        }
        
    }
    
    func say(content: String) {
        print(content)
    }
    
    func setName(name: String) -> Person {
        self.name = name
        return self
    }
    
    func setAge(age: Int) -> Person {
        self.age = age
        return self
    }
}
