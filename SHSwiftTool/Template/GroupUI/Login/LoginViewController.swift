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
    
    private var navigationBarViewHolder: NavigationBarViewHolder?
    
    @IBOutlet var textFieldID: UITextField!
    @IBOutlet var textFieldPW: UITextField!
    @IBOutlet var autoLoginSwitch: UISwitch!
    
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
        updateView()
    }
    
    func onButtonLeftClicked() {
        ILog.debug(tag: LoginViewController.TAG, content: "onButtonLeftClicked")
        NavigationUtil.navigationToPrev(from: self, animated: true)
    }
    
    func onButtonRightClicked() {
        ILog.debug(tag: LoginViewController.TAG, content: "onButtonRightClicked")
    }
    
    private func updateView() {
        
        loginInfoModel = LoginInfoModel(
            userID: UserDefaultsUtil.get(key: LoginConstants.ID_KEY),
            userPassword: UserDefaultsUtil.get(key: LoginConstants.PW_KEY),
            autoLogin: UserDefaultsUtil.get(key: LoginConstants.AUTO_LOGIN_KEY))
        
        if(loginInfoModel.getAutoLogin()) {
            autoLogin()
        }
        
    }
    
    private func initNavigationBar() {
        
        if(navigationBarViewHolder == nil) {
            navigationBarViewHolder = NavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
            navigationBarViewHolder!.setTitle(title: "Login")
            navigationBarViewHolder!.hideRightButton()
            navigationBarViewHolder!.setLeftButtonImage(imageName: "icon_back.png")
            
            navigationBarViewHolder!.setDelegate(navigationBarViewHolderDelegate: self)
            
            self.view.addSubview(navigationBarViewHolder!)
        }
    }
    
    private func removeNavigationBar() {
        if(navigationBarViewHolder != nil) {
            ILog.debug(tag: LoginViewController.TAG, content: "removeNavigationBar")
            navigationBarViewHolder?.removeFromSuperview()
            navigationBarViewHolder = nil;
        }
    }
    
    private func setListener() {
        self.buttonLogin.addTarget(self, action: #selector(self.onButtonLoginClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonLoginClicked(_ sender: UIButton) {
        ILog.debug(tag: LoginViewController.TAG, content: "onButtonLoginTemplateClicked")
        
        if(!check()) {
            return
        }
        
        login()
    }
    
    private func check() -> Bool {
        
        if(textFieldID.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "") {
            AlertViewUtil.showOneButtonAlertView(from: self, setTitle: "Login", setMessage: "Input id please", setButtonTitle: "Confirm")
            textFieldID.text = ""
            return false;
        }
        
        if(textFieldPW.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "") {
            AlertViewUtil.showOneButtonAlertView(from: self, setTitle: "Login", setMessage: "Input password please", setButtonTitle: "Confirm")
            textFieldPW.text = ""
            return false;
        }
        
        return true
        
    }
    
    private func autoLogin() {
        
        let alertWaitingViewHolder = AlertWaitingViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(alertWaitingViewHolder)
        
        ThreadUtil.startThread {
            // do login
            
            ThreadUtil.startUIThread(runnable: {
                
                alertWaitingViewHolder.removeFromSuperview()
                NavigationUtil.navigationToPrev(from: self, animated: true)
                
                var userInfo = Dictionary<AnyHashable, Any>()
                userInfo[LoginConstants.ID_KEY] = self.loginInfoModel.getUserID()
                userInfo[LoginConstants.PW_KEY] = self.loginInfoModel.getUserPassword()
                NotificationUtil.post(name: NotificationConstants.LOGIN_SUCCESS, userInfo: userInfo)
                
                
            }, afterSeconds: 3)
        }
        
        ILog.debug(tag: LoginViewController.TAG, content: "auto login...")
        
    }
    
    private func login() {
        
        let id = textFieldID.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let pw = textFieldPW.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        loginInfoModel = LoginInfoModel(userID: id!, userPassword: pw!, autoLogin: autoLoginSwitch.isOn)
        
        UserDefaultsUtil.save(key: LoginConstants.ID_KEY, andValue: loginInfoModel.getUserID())
        UserDefaultsUtil.save(key: LoginConstants.PW_KEY, andValue: loginInfoModel.getUserPassword())
        UserDefaultsUtil.save(key: LoginConstants.AUTO_LOGIN_KEY, andValue: loginInfoModel.getAutoLogin())
       
        ILog.debug(tag: LoginViewController.TAG, content: loginInfoModel.getUserID())
        ILog.debug(tag: LoginViewController.TAG, content: loginInfoModel.getUserPassword())
        ILog.debug(tag: LoginViewController.TAG, content: loginInfoModel.getAutoLogin())
        
        let alertWaitingViewHolder = AlertWaitingViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(alertWaitingViewHolder)
        
        ThreadUtil.startThread {
            // do login
            
            ThreadUtil.startUIThread(runnable: {
               
                alertWaitingViewHolder.removeFromSuperview()
                NavigationUtil.navigationToPrev(from: self, animated: true)

                var userInfo = Dictionary<AnyHashable, Any>()
                userInfo[LoginConstants.ID_KEY] = self.loginInfoModel.getUserID()
                userInfo[LoginConstants.PW_KEY] = self.loginInfoModel.getUserPassword()
                NotificationUtil.post(name: NotificationConstants.LOGIN_SUCCESS, userInfo: userInfo)
                
                
            }, afterSeconds: 3)
        }
        
        ILog.debug(tag: LoginViewController.TAG, content: "login...")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ILog.debug(tag: LoginViewController.TAG, content: "viewDidDisappear")
        removeNavigationBar()
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
