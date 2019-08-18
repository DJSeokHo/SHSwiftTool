//
//  AlertViewUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 18/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation
import UIKit

class AlertViewUtil {
    
    
    public static func showOneButtonAlertView(from: UIViewController, setTitle title: String, setMessage message: String, setButtonTitle buttonTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
      
        from.present(alert, animated: true)
    }
    
}
