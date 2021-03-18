//
//  UIViewExtension.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/03/18.
//  Copyright © 2021 SWein. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public func viewSetOnClickListener(_ target: Any?, action: Selector) {

        self.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(guestureRecognizer)
        
    }
    
}
