//
//  BasicEnum.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 23/06/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

enum SomeEnum {
    case up, down, left, right
}

enum Beverage: CaseIterable {
    case coffee, tea, juice
}

class BasicEnum {
    
    func enumWithSwitch(someEnum: SomeEnum) {
        
        switch someEnum {
            
            case SomeEnum.up:
                break
            
            case SomeEnum.down:
                break
            
            case SomeEnum.left:
                break
            
            case SomeEnum.right:
                break
            
            default:
                print("not match")
        }
        
    }
    
    /*
        遍历一个枚举需要枚举实现一个CaseIterable协议
    */
    func enumAllCase() {
        for enumItem in Beverage.allCases {
            print(enumItem)
        }
    }
}
