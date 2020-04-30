//
//  ColorUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/30.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class ColorUtil {
    
    public static func colorWithRGB(r: CGFloat, g: CGFloat, b: CGFloat, alpha:CGFloat) -> UIColor
    {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    public static func colorWithHexString(_ hex:String) -> UIColor {
        var string:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (string.hasPrefix("#")) {
            string = (string as NSString).substring(from: 1)
        }
        
        if (string.count != 6) {
            return UIColor.clear
        }
        
        let rString = (string as NSString).substring(to: 2)
        let gString = ((string as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((string as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    public static func colorWithHexString(_ hex: String, alpha: CGFloat) -> UIColor {
        var string:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (string.hasPrefix("#")) {
            string = (string as NSString).substring(from: 1)
        }
        
        if (string.count != 6) {
            return UIColor.clear
        }
        
        let rString = (string as NSString).substring(to: 2)
        let gString = ((string as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((string as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
}
