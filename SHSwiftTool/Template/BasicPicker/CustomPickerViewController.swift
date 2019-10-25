//
//  CustomPickerViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2019/10/25.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation
import UIKit

class CustomPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    
}
