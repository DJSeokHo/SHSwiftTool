//
//  SoftKeyboardUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2019/10/22.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation
import UIKit

class SoftKeyboardUtil {
    
    public static func tapSpaceToCloseSoftKeyboard(target: UIViewController, action: Selector) {

        let tap = UITapGestureRecognizer(target: target, action: action)
               tap.cancelsTouchesInView = false
               target.view.addGestureRecognizer(tap)
    }
   
}
