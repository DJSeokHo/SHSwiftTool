//
//  KeepAccountMainViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/30.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KeepAccountMainViewController: UIViewController {
    
    public static let TAG = "KeepAccountMainViewController"
    
    @IBOutlet var buttonAdd: UIButton!
    
    private var customCenterSelectUITabBarViewController: CustomCenterSelectUITabBarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ILog.debug(tag: #file, content: "viewDidLoad")
        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        setListener()
        ViewUtil.setShadow(view: buttonAdd, color: UIColor.black.cgColor, radius: 6, opacity: 1.0)
        
    }

    override func viewWillAppear(_ animated: Bool) {
       
        initCenterSelectTabBar()
        self.view.bringSubviewToFront(buttonAdd)
    }
    
    private func setListener() {
        buttonAdd.addTarget(self, action: #selector(onButtonAddClick), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonAddClick(_ sender: UIButton) {
      
        let kaAccountDetailViewController = KAAccountDetailViewController()
        kaAccountDetailViewController.navigationBarTitle = "Add New"
        ViewControllerUtil.startNewFullScreenViewController(from: self, target: kaAccountDetailViewController)
    }
    
    private func initCenterSelectTabBar() {
        
        if customCenterSelectUITabBarViewController != nil {
            return
        }
        
        customCenterSelectUITabBarViewController = CustomCenterSelectUITabBarViewController()

        customCenterSelectUITabBarViewController.tabBarTitleArray.append(contentsOf: ["Map", "", "Setting"])
        customCenterSelectUITabBarViewController.tabBarSelectedImageArray.append(contentsOf: ["icon_map_selected", "", "icon_setting_selected"])
        customCenterSelectUITabBarViewController.tabBarUnSelectedImageArray.append(contentsOf: ["icon_map", "", "icon_setting"])

        let kaMapViewController = KAMapViewController()
        let kaAccountViewController = KAAccountViewController()
        let kaSettingViewController = KASettingViewController()

        customCenterSelectUITabBarViewController.subViewControllerArray.append(contentsOf:[kaMapViewController, kaAccountViewController, kaSettingViewController])
        
        let size = DisplayUtil.getFullScreenSize()
        let tabBar = CustomCenterSelectUITabBar(frame: CGRect(x: 0, y: 100, width: Int(size.width), height: KAConstants.BOTTOM_TAB_BAR_HEIGHT))
        customCenterSelectUITabBarViewController.setTabBar(tabBar: tabBar)

        self.addChild(customCenterSelectUITabBarViewController)
        self.view.addSubview(customCenterSelectUITabBarViewController.view)

        ILog.debug(tag: "???", content: "\(customCenterSelectUITabBarViewController.tabBar.frame.width) \(customCenterSelectUITabBarViewController.tabBar.frame.height)")
    }
    
//    private func initCenterClickTabBar() {
//
//        if customCenterClickUITabBarViewController != nil {
//            return
//        }
//
//        customCenterClickUITabBarViewController = CustomCenterClickUITabBarViewController()
//
//        customCenterClickUITabBarViewController.tabBarTitleArray.append(contentsOf: ["Map", "Setting"])
//        customCenterClickUITabBarViewController.tabBarSelectedImageArray.append(contentsOf: ["icon_map_selected", "icon_setting_selected"])
//        customCenterClickUITabBarViewController.tabBarUnSelectedImageArray.append(contentsOf: ["icon_map", "icon_setting"])
//
//        let kaMapViewController = KAMapViewController()
//        let kaSettingViewController = KASettingViewController()
//
//        customCenterClickUITabBarViewController.subViewControllerArray.append(contentsOf:[kaMapViewController, kaSettingViewController])
//
//        let size = DisplayUtil.getFullScreenSize()
//        let tabBar = CustomCenterSelectUITabBar(frame: CGRect(x: 0, y: 100, width: size.width, height: 60))
//        customCenterClickUITabBarViewController.setTabBar(tabBar: tabBar)
//
//        self.addChild(customCenterClickUITabBarViewController)
//        self.view.addSubview(customCenterClickUITabBarViewController.view)
//    }
    
//    private func initNormalTabBar() {
//
//        if customNormalUITabBarViewController != nil {
//            return
//        }
//
//        customNormalUITabBarViewController = CustomNormalUITabBarViewController()
//
//        let size = DisplayUtil.getFullScreenSize()
//
//        let tabBar = CustomNormalUITabBar(frame: CGRect(x: 0, y: 100, width: size.width, height: 60))
//
//        customNormalUITabBarViewController.tabBarTitleArray.append(contentsOf: ["Map", "Account", "Setting"])
//        customNormalUITabBarViewController.tabBarSelectedImageArray.append(contentsOf: ["icon_map_selected", "icon_keep_account", "icon_setting_selected"])
//        customNormalUITabBarViewController.tabBarUnSelectedImageArray.append(contentsOf: ["icon_map", "icon_keep_account_un_selected", "icon_setting"])
//
//        let kaMapViewController = KAMapViewController()
//        let kaAccountViewController = KAAccountViewController()
//        let kaSettingViewController = KASettingViewController()
//
//        customNormalUITabBarViewController.subViewControllerArray.append(contentsOf:[kaMapViewController, kaAccountViewController, kaSettingViewController])
//
//        customNormalUITabBarViewController.setTabBar(tabBar: tabBar)
//
//        self.addChild(customNormalUITabBarViewController)
//        self.view.addSubview(customNormalUITabBarViewController.view)
//
//        ILog.debug(tag: "???", content: "\(customNormalUITabBarViewController.tabBar.frame.width) \(customNormalUITabBarViewController.tabBar.frame.height)")
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
