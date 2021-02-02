//
//  AutoLayoutTestViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/01/19.
//  Copyright © 2021 SWein. All rights reserved.
//

import UIKit

class AutoLayoutTestViewController: UIViewController {

    @IBOutlet var viewBottom: UIView!
    @IBOutlet var viewHeader: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        view.backgroundColor = UIColor.red
//
//        self.view.addSubview(view)
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
////        view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
//        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
    }

    @IBAction func onLeftButtonClick(_ sender: Any) {
        
        viewHeader.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
    }
    
    @IBAction func onRightButtonClick(_ sender: Any) {
        viewBottom.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
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
