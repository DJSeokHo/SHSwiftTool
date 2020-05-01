//
//  ViewUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class ViewUtil {
    
    public static func setShadow(view: UIView, color: CGColor, radius: CGFloat, opacity: Float) {
        
        view.layer.shadowColor = color
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = radius
        view.layer.shadowOpacity = opacity
        
    }
    
    public static func setShadow(view: UIView, color: CGColor, radius: CGFloat, opacity: Float, offsetWidth: Int, offsetHeight: Int) {
        
        view.layer.shadowColor = color
        view.layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        view.layer.shadowRadius = radius
        view.layer.shadowOpacity = opacity
        
    }
}
