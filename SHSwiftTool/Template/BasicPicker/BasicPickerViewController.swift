//
//  BasicPickerViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2019/10/25.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class BasicPickerViewController: UIViewController {

    @IBAction func onButtonBasicPickerClick(_ sender: UIButton) {
        ViewControllerUtil.finishSelf(view: self)
    }
    
    @IBOutlet var pickerView: UIPickerView!
    
    
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
