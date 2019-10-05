//
//  AppleEatable.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 05/10/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation

class AppleEatable: Eatable {
   
    public static let TAG: String = "AppleEatable"
    
    var name: String = ""
    
    func taste() {
        print("apple taste")
    }
 
    func test(_ massages: String...) {
        
        for message in massages {
            print(message)
        }
    }
    
    static func info(_ peopleName: String) {
        print("Hey \(peopleName), this is apple")
    }
    
    func drop() {
        print("drop me")
    }
}
