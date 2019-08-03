//
//  LoginViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 03/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private static let TAG = "LoginViewController"
    
    
    @IBOutlet var textFieldID: UITextField!
    @IBOutlet var textFieldPW: UITextField!
    
    @IBOutlet var labelAutoLoginResult: UILabel!
    @IBAction func switchAutoLogin(_ sender: UISwitch) {
        ILog.debug(tag: LoginViewController.TAG, content: sender.isOn)
        if(sender.isOn) {
            labelAutoLoginResult.text = "Yes"
        }
        else {
            labelAutoLoginResult.text = "No"
        }
    }
    
    @IBOutlet var buttonLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setListener()
    }

    private func setListener() {
        self.buttonLogin.addTarget(self, action: #selector(self.onButtonLoginClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonLoginClicked(_ sender: UIButton) {
        ILog.debug(tag: LoginViewController.TAG, content: "onButtonLoginTemplateClicked")
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
