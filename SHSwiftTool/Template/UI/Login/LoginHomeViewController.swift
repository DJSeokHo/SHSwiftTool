//
//  LoginHomeViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 04/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class LoginHomeViewController: UIViewController, NavigationBarViewHolderDelegate {
    

    private static let TAG = "LoginHomeViewController"
    
    public var fromWhere: String?
   
    @IBOutlet var labelLoginInfo: UILabel!
    @IBOutlet var buttonLogin: UIButton!
    @IBOutlet var buttonLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initObserver()
        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        setListener()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "viewWillAppear")
        initNavigationBar()
        labelLoginInfo.text = fromWhere
    }
    
    private func initObserver() {
        
        NotificationUtil.addObserver(observer: self, selector: #selector(observerLoginSuccess(notfication:)), name: NotifcationConstants.LOGIN_SUCCESS)
       
    }
    
    @objc func observerLoginSuccess(notfication: NSNotification) {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "observerLoginSuccess")
        
        let userInfo = notfication.userInfo
        
        let id = userInfo![LoginConstants.ID_KEY]!
        let pw = userInfo![LoginConstants.PW_KEY]!
        
        ILog.debug(tag: LoginHomeViewController.TAG, content: userInfo![LoginConstants.ID_KEY]!)
        ILog.debug(tag: LoginHomeViewController.TAG, content: userInfo![LoginConstants.PW_KEY]!)
        
        fromWhere = """
        From observerLoginSuccess
        \(id)
        \(pw)
        """
        labelLoginInfo.text = fromWhere
    }
    
    private func initNavigationBar() {
        
        let navigationBarViewHolder = NavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        navigationBarViewHolder.setTitle(title: "Login Home")
        navigationBarViewHolder.setRightButtonImage(imageName: "icon_close.png")
        navigationBarViewHolder.hideLeftButton()
        
        navigationBarViewHolder.setDelegate(navigationBarViewHolderDelegate: self)
        
        self.view.addSubview(navigationBarViewHolder)  
    }
    
    func onButtonLeftClicked() {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "onButtonLeftCLicked")
    }
    
    func onButtonRightClicked() {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "onButtonRightClicked")
        ViewControllerUtil.finishSelf(view: self)
    }
    

    private func setListener() {
        self.buttonLogin.addTarget(self, action: #selector(self.onButtonLoginClicked(_:)), for: UIControl.Event.touchUpInside)
        self.buttonLogout.addTarget(self, action: #selector(self.onButtonLogoutClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonLoginClicked(_ sender: UIButton) {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "onButtonLoginClicked")
        NavigationUtil.navigationToNext(from: self, target: LoginViewController(), animated: true)
    }
    
    @objc private func onButtonLogoutClicked(_ sender: UIButton) {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "onButtonLogoutClicked")
        
        UserDefaultsUtil.save(key: LoginConstants.ID_KEY, andValue: "")
        UserDefaultsUtil.save(key: LoginConstants.PW_KEY, andValue: "")
        UserDefaultsUtil.save(key: LoginConstants.AUTO_LOGIN_KEY, andValue: false)
        
        ViewControllerUtil.finishSelf(view: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "viewDidDisappear")
        
    }
    
    deinit {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "deinit")
        NotificationUtil.removeAllObserver(observer: self)
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
