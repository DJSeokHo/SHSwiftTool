//
//  DashboardViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 21/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, NavigationBarViewHolderDelegate {
   
    private static let TAG = "DashboardViewController"

    public static let TITLE = "Dashboard"
    
    
    @IBOutlet var buttonTest: UIButton!
    
    private var navigationBarViewHolder: NavigationBarViewHolder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        setListener()
    }

    private func setListener() {
        self.buttonTest.addTarget(self, action: #selector(self.onButtonTestClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonTestClicked(_ sender: UIButton) {
        ILog.debug(tag: DashboardViewController.TAG, content: "onButtonTestClicked")
        let mainViewController: MainViewController = MainViewController()
        ViewControllerUtil.startNewFullScreenViewController(from: self, target: mainViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
    
    private func initNavigationBar() {
        
        if(navigationBarViewHolder == nil) {
            navigationBarViewHolder = NavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
            navigationBarViewHolder!.setTitle(title: DashboardViewController.TITLE)
            navigationBarViewHolder!.hideRightButton()
            navigationBarViewHolder!.hideLeftButton()
            
            navigationBarViewHolder!.setDelegate(navigationBarViewHolderDelegate: self)
            
            self.view.addSubview(navigationBarViewHolder!)
        }
    }
    
    func onButtonLeftClicked() {
        ILog.debug(tag: DashboardViewController.TAG, content: "onButtonLeftClicked")
    }
    
    func onButtonRightClicked() {
        ILog.debug(tag: DashboardViewController.TAG, content: "onButtonRightClicked")
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
