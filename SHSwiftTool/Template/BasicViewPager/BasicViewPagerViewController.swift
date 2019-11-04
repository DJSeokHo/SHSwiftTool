//
//  BasicViewPagerViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2019/11/04.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class BasicViewPagerViewController: UIViewController {

    @IBAction func onButtonCloseClick(_ sender: UIButton) {
        ViewControllerUtil.finishSelf(view: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
