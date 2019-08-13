//
//  LoginHomeViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 04/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class LoginHomeViewController: UIViewController {

    private static let TAG = "LoginHomeViewController"
    
    
    @IBOutlet var labelUserID: UILabel!
    
    @IBOutlet var buttonLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideSystemNavigationBar()
        setListener()
    }
    deinit {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "deinit")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
    
    private func initNavigationBar() {
        
        let navigationBarViewHolder = NavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
     
        self.view.addSubview(navigationBarViewHolder)
        
    }
    
    private func hideSystemNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    private func showSystemNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setListener() {
        self.buttonLogin.addTarget(self, action: #selector(self.onButtonLoginClicked(_:)), for: UIControl.Event.touchUpInside)
        
//        self.buttonClose.addTarget(self, action: #selector(self.onButtonCloseClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonLoginClicked(_ sender: UIButton) {
        ILog.debug(tag: LoginHomeViewController.TAG, content: "onButtonLoginClicked")
        let loginViewController = LoginViewController();
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
//
//    @objc private func onButtonCloseClicked(_ sender: UIButton) {
//        ILog.debug(tag: LoginHomeViewController.TAG, content: "onButtonCloseClicked")
//        self.dismiss(animated: true, completion: nil)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
