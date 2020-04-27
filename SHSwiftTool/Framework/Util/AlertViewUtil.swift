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
    
    public static func showTwoButtonAlertView(from: UIViewController, setTitle title: String, setMessage message: String, setConfirmButtonTitle confirmTitle: String, setCancelButtonTitle cancelTitle: String, setConfirmDelegate confirmDelegate: @escaping ((UIAlertAction) -> Void)) {
        
        /*
         alert.addAction(UIAlertAction(title: "title", style: UIAlertAction.Style.default, handler: { action in
         
            print("action!!!")
         
         }))
        */
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: confirmTitle, style: UIAlertAction.Style.default, handler: confirmDelegate))
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: nil))
        
        from.present(alert, animated: true)
    }
    
    public static func showTwoButtonWithOneInputAlertView(from: UIViewController, setTitle title: String, setMessage message: String, setInputPlaceHolder placeHolder: String, setContent content: String, setConfirmButtonTitle confirmTitle: String, setCancelButtonTitle cancelTitle: String, setConfirmDelegate confirmDelegate: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle:  UIAlertController.Style.alert)

        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = placeHolder
            textField.text = content
        }
      
        let confirmAction = UIAlertAction(
            title: confirmTitle,
            style: UIAlertAction.Style.default) {
                (action: UIAlertAction!) -> Void in
                
                let content = (alertController.textFields?.first)! as UITextField
               
                if content.text == nil || content.text == "" {
                    return
                }
                
                confirmDelegate(content.text!)
            }
        
        alertController.addAction(confirmAction)
        
        alertController.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler: nil))
        from.present(alertController, animated: true)
    }
}
