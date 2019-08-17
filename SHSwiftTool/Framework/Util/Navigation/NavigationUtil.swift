//
//  NavigationUtil.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 17/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation
import UIKit

class NavigationUtil {
    
    private static let TAG = "NavigationUtil"
    
    public static func hideSystemNavigationBar(navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(true, animated: false)
        
    }
    
    public static func showSystemNavigationBar(navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    public static func navigationToNext(from: UIViewController, target: UIViewController, animated: Bool) {
        from.navigationController?.pushViewController(target, animated: animated)
    }
    
    public static func navigationToPrev(from: UIViewController, animated: Bool) {
        from.navigationController?.popViewController(animated: animated)
    }
}
