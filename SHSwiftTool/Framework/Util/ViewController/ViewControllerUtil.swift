//
//  ViewControllerUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 17/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerUtil {
    
    private static let TAG = "ViewControllerUtil"
    
    public static func startNewViewController(from: UIViewController, target: UIViewController) {
        from.present(target, animated: true, completion: nil)
    }
    
    public static func startNewViewControllerWithNavigation(from: UIViewController, target: UIViewController) {
      
        // create navigation controller and put main view controller as root view
        let navigationController: UINavigationController = UINavigationController(rootViewController: target)
        
        // make navigation controller as window root view controller
        //        self.window!.rootViewController = navigationController
        from.present(navigationController, animated: true, completion: nil)
    }
    
    public static func finishSelf(view: UIViewController) {
        view.dismiss(animated: true, completion: nil)
    }
    
}
