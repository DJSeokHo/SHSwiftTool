//
//  OrderViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 21/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    public static let TITLE = "Order"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
