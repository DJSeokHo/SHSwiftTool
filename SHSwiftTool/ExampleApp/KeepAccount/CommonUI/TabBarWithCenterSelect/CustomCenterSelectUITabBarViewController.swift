//
//  CustomCenterSelectUITabBarViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class CustomCenterSelectUITabBarViewController: UITabBarController, CustomCenterSelectUITabBarDelegate {

    public var tabBarTitleArray: [String] = [String]()
    public var tabBarSelectedImageArray: [String] = [String]()
    public var tabBarUnSelectedImageArray: [String] = [String]()
    public var subViewControllerArray: [UIViewController] = [UIViewController]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().backgroundColor = ColorUtil.colorWithHexString("ffffff")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    public func setTabBar(tabBar: UITabBar) {
        
        let tab = CustomCenterSelectUITabBar()
        tab.customCenterSelectUITabBarDelegate = self
        self.setValue(tab, forKey: "tabBar")
        self.setRootTabbarConntroller()
        
    }
    
    // MARK: delegate
    func onPlusClick() {
        print("onPlusClick")
        selectedIndex = 1
    }
    // MARK: delegate
   
    func setRootTabbarConntroller() {
       
        for i in 0..<self.tabBarUnSelectedImageArray.count {
         
            // if you need navigation controller
            let nav = UINavigationController(rootViewController: subViewControllerArray[i])
            
            let barItem = UITabBarItem.init(title: self.tabBarTitleArray[i], image: UIImage.init(named: self.tabBarUnSelectedImageArray[i])?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: self.tabBarSelectedImageArray[i])?.withRenderingMode(.alwaysOriginal))
            
            barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : ColorUtil.colorWithHexString("666666")], for: .normal)
            barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : ColorUtil.colorWithHexString("000000")], for: .selected)
         
            subViewControllerArray[i].tabBarItem = barItem
            
            self.addChild(nav)
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        var frame = self.tabBar.frame
        frame.size.height = 90;
        frame.origin.y = self.view.frame.size.height - frame.size.height
        self.tabBar.frame = frame
        
        self.tabBar.backgroundColor = ColorUtil.colorWithHexString("999999")
        self.tabBar.isTranslucent = true
        
        self.tabBar.barStyle = .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

