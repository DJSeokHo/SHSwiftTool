//
//  StringExtension.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 05/10/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

/*
 拓展了String类
 添加了一个实体方法和一个静态方法
 */
extension String {
    public static let TAG: String = "String"
    
    public func printInfoExtension() {
        print("this is extension of String")
    }
}

class ExtensionTest {
    public var name: String = ""
    
    func printInfo() {
        
        name.printInfoExtension()
        
        print(String.TAG)
    }
}
