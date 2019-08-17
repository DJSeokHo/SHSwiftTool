//
//  LoginViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 03/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, NavigationBarViewHolderDelegate {
   

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
    
    private var loginInfoModel: LoginInfoModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        setListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
    
    func onButtonLeftClicked() {
        ILog.debug(tag: LoginViewController.TAG, content: "onButtonLeftClicked")
        NavigationUtil.navigationToPrev(from: self, animated: true)
    }
    
    func onButtonRightClicked() {
        ILog.debug(tag: LoginViewController.TAG, content: "onButtonRightClicked")
    }
    
    private func initNavigationBar() {
        
        let navigationBarViewHolder = NavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        navigationBarViewHolder.setTitle(title: "Login")
        navigationBarViewHolder.hideRightButton()
        navigationBarViewHolder.setLeftButtonImage(imageName: "icon_back.png")
        
        navigationBarViewHolder.setDelegate(navigationBarViewHolderDelegate: self)
        
        self.view.addSubview(navigationBarViewHolder)
    }
    
    private func setListener() {
        self.buttonLogin.addTarget(self, action: #selector(self.onButtonLoginClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonLoginClicked(_ sender: UIButton) {
        ILog.debug(tag: LoginViewController.TAG, content: "onButtonLoginTemplateClicked")

        login()
            }
    
    private func login() {
        let alertWaitingViewHolder = AlertWaitingViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(alertWaitingViewHolder)
        
        ThreadUtil.startThread {
            // do login
            
            ThreadUtil.startUIThread(runnable: {
               
                alertWaitingViewHolder.removeFromSuperview()
                NavigationUtil.navigationToPrev(from: self, animated: true)

                NotificationCenter.default.post(name: Notification.Name(rawValue: NotifcationConstants.LOGIN_SUCCESS), object: self, userInfo: nil)
                
            }, after: 3)
        }
        
        ILog.debug(tag: LoginViewController.TAG, content: "login...")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ILog.debug(tag: LoginViewController.TAG, content: "viewDidDisappear")
        NotificationCenter.default.removeObserver(self)
    }
    
    
    deinit {
        ILog.debug(tag: LoginViewController.TAG, content: "deinit")
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
