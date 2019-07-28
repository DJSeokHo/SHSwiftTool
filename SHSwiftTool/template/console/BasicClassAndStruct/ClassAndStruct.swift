//
//  BasicClass.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 28/07/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class ClassAndStruct {
    
    func classTest() {
        let person: Person = Person()
        
        person.name = "who"
        person.age = 30
        person.say(content: "haha")
        print("\(person.name) \(person.age)")
        
        /* 该变量含有属性观察者 */
        person.fullName = "full-name"
        
        let wolf: Wolf = Wolf(name: "wolf", age: 8)
        wolf.info()
        
        // 链式调用
        person.setName(name: "person").setAge(age: 32).say(content: "hehe")
        print("\(person.name) \(person.age)")
        
        let user = User(first: "user", last: "who")
        print(user.fullName)
        
        user.fullName = "haha-hehe"
        print("\(user.first) \(user.last)")
    }
    
    func structTest() {
        let dog = Dog()
        dog.name = "dog"
        dog.age = 9
        dog.run()
        dog.jump()
    }
}
