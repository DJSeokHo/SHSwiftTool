//
//  LoginResultViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/04/20.
//  Copyright © 2021 SWein. All rights reserved.
//

import UIKit

class LoginResultViewController: UIViewController {

    public var result = ""
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text = result
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
