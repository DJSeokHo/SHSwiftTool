//
//  BasicString.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 22/06/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class BasicString {
    
    
    func stringTest() {
        
        let quotation = """
        The White Rabbit put on his spectacles.  "Where shall I begin,
        please your Majesty?" he asked.

        "Begin at the beginning," the King said gravely, "and go on
        till you come to the end; then stop."
        """
        print(quotation)
        
        // 初始化空字符串
        var anotherEmptyString = String()
        
        
        var welcome = "hello"
        welcome.insert("!", at: welcome.endIndex)
        // welcome 变量现在等于 "hello!"
        
        welcome.insert(contentsOf:" there", at: welcome.index(before: welcome.endIndex))
        // welcome 变量现在等于 "hello there!"
        
        welcome.remove(at: welcome.index(before: welcome.endIndex))
        // welcome 现在等于 "hello there"
        
        let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)
        // welcome 现在等于 "hello"
    }
    
}
