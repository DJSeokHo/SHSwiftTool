//
//  KeepAccountMainViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/30.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KeepAccountMainViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        initCenterSelectTabBar()
    }
    
    private func initCenterClickTabBar() {
        
        let size = DisplayUtil.getFullScreenSize()
               
        let tabBar = CustomCenterSelectUITabBar(frame: CGRect(x: 0, y: 100, width: size.width, height: 60))

        let customCenterClickUITabBarViewController = CustomCenterClickUITabBarViewController()

        customCenterClickUITabBarViewController.tabBarTitleArray.append(contentsOf: ["Map", "Setting"])
        customCenterClickUITabBarViewController.tabBarSelectedImageArray.append(contentsOf: ["icon_map_selected", "icon_setting_selected"])
        customCenterClickUITabBarViewController.tabBarUnSelectedImageArray.append(contentsOf: ["icon_map", "icon_setting"])

        let kaMapViewController = KAMapViewController()
        let kaSettingViewController = KASettingViewController()

        customCenterClickUITabBarViewController.subViewControllerArray.append(contentsOf:[kaMapViewController, kaSettingViewController])
        
        customCenterClickUITabBarViewController.setTabBar(tabBar: tabBar)

        self.addChild(customCenterClickUITabBarViewController)
        self.view.addSubview(customCenterClickUITabBarViewController.view)

        ILog.debug(tag: "???", content: "\(customCenterClickUITabBarViewController.tabBar.frame.width) \(customCenterClickUITabBarViewController.tabBar.frame.height)")
        
    }
    
    private func initCenterSelectTabBar() {
        
        let size = DisplayUtil.getFullScreenSize()
               
        let tabBar = CustomCenterSelectUITabBar(frame: CGRect(x: 0, y: 100, width: size.width, height: 60))

        let customCenterSelectUITabBarViewController = CustomCenterSelectUITabBarViewController()

        customCenterSelectUITabBarViewController.tabBarTitleArray.append(contentsOf: ["Map", "", "Setting"])
        customCenterSelectUITabBarViewController.tabBarSelectedImageArray.append(contentsOf: ["icon_map_selected", "", "icon_setting_selected"])
        customCenterSelectUITabBarViewController.tabBarUnSelectedImageArray.append(contentsOf: ["icon_map", "", "icon_setting"])

        let kaMapViewController = KAMapViewController()
        let kaAccountViewController = KAAccountViewController()
        let kaSettingViewController = KASettingViewController()

        customCenterSelectUITabBarViewController.subViewControllerArray.append(contentsOf:[kaMapViewController, kaAccountViewController, kaSettingViewController])
        
        customCenterSelectUITabBarViewController.setTabBar(tabBar: tabBar)

        self.addChild(customCenterSelectUITabBarViewController)
        self.view.addSubview(customCenterSelectUITabBarViewController.view)

        ILog.debug(tag: "???", content: "\(customCenterSelectUITabBarViewController.tabBar.frame.width) \(customCenterSelectUITabBarViewController.tabBar.frame.height)")
        
    }

    private func initNormalTabBar() {
        
        let size = DisplayUtil.getFullScreenSize()

        let tabBar = CustomNormalUITabBar(frame: CGRect(x: 0, y: 100, width: size.width, height: 60))

        let customNormalUITabBarViewController = CustomNormalUITabBarViewController()

        customNormalUITabBarViewController.tabBarTitleArray.append(contentsOf: ["Map", "Account", "Setting"])
        customNormalUITabBarViewController.tabBarSelectedImageArray.append(contentsOf: ["icon_map_selected", "icon_keep_account", "icon_setting_selected"])
        customNormalUITabBarViewController.tabBarUnSelectedImageArray.append(contentsOf: ["icon_map", "icon_keep_account_un_selected", "icon_setting"])

        let kaMapViewController = KAMapViewController()
        let kaAccountViewController = KAAccountViewController()
        let kaSettingViewController = KASettingViewController()

        customNormalUITabBarViewController.subViewControllerArray.append(contentsOf:[kaMapViewController, kaAccountViewController, kaSettingViewController])

        customNormalUITabBarViewController.setTabBar(tabBar: tabBar)

        self.addChild(customNormalUITabBarViewController)
        self.view.addSubview(customNormalUITabBarViewController.view)

        ILog.debug(tag: "???", content: "\(customNormalUITabBarViewController.tabBar.frame.width) \(customNormalUITabBarViewController.tabBar.frame.height)")
        
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
