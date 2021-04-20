//
//  LoginExampleViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/04/20.
//  Copyright © 2021 SWein. All rights reserved.
//

import UIKit

class LoginExampleViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var buttonLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ILog.debug(tag: #file, content: "LoginExampleViewController")
        // Do any additional setup after loading the view.
    
        label.text = "Hello"
        buttonLogin.setTitle("123", for: .normal)
        buttonLogin.addTarget(self, action: #selector(onButtonLoginClick), for: .touchUpInside)
    }
    @objc private func onButtonLoginClick() {

        ILog.debug(tag: #file, content: "???")

//        let viewController = LoginResultViewController()
//        viewController.result = "haha"
//        ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: viewController)
        
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "LoginResultViewController") as! LoginResultViewController
        
        viewController.result = "vvv"
//        let storyboard = UIStoryboard(name: "LoginExample", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginExampleViewController")
    
//                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginExampleViewController")
//
//        ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: viewController)
        
        ViewControllerUtil.startNewViewControllerWithNavigation(from: self, target: viewController)
        
        
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
