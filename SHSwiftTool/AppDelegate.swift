//
//  AppDelegate.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 21/06/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        FirebaseApp.configure()
        
        initMainViewController()
//        initBottomTabBar()
//        initBottomTabBarWithNavigation()
//
//        window = UIWindow.init(frame: UIScreen.main.bounds)
//        window?.backgroundColor = UIColor.white
//        window?.makeKeyAndVisible()
//        window?.rootViewController = CustomUITabBarViewController()
        
        
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window!.backgroundColor = UIColor.white
        
        // create main container view controller
//        let viewController: IGLikeCollectionView = IGLikeCollectionView()
//        let viewController = StackViewTestViewController()
//        let viewController = AutoLayoutTestViewController()
//        let viewController: AutoStackViewController = AutoStackViewController()
//        let viewController = FileDownloadWebViewController()
//        viewController.urlString = "https://www.nowon.kr/www/user/bbs/BD_selectBbs.do?q_bbsCode=1003&q_bbscttSn=20210114163838935&q_clCode=0&q_estnColumn7=Y"
        
        
        
        // create navigation controller and put main view controller as root view
        //        let navigationController: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        // make navigation controller as window root view controller
        //        self.window!.rootViewController = navigationController
//        window!.rootViewController = viewController
//        window!.makeKeyAndVisible()
        
        
        
        return true
    }
    
    private func initMainViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        
        // create main container view controller
        let mainViewController: MainViewController = MainViewController()
       
        // create navigation controller and put main view controller as root view
        //        let navigationController: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        // make navigation controller as window root view controller
        //        self.window!.rootViewController = navigationController
        window!.rootViewController = mainViewController
        window!.makeKeyAndVisible()
    }
    
    /*
     UITabBarController通常最为整个程序的rootViewController，而且不能添加到别的视图控制器中，
     UITabBarController主要用来管理用户提供的包含各种内容的子视图控制器，
     而每一个子视图控制器则负责管理自己的视图层级关系。
     
     @1x : 推荐 25 x 25   (最大: 48 x 32)
     @2x : 推荐 50 x 50   (最大: 96 x 64)
     @3x : 推荐 75 x 75   (最大: 144 x 96)
     */
    private func initBottomTabBarWithNavigation() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        
        let dashboardViewController = DashboardViewController()
        dashboardViewController.tabBarItem.image = UIImage(named: "icon_dashboard_un_selected")?.withRenderingMode(.alwaysOriginal)
        dashboardViewController.tabBarItem.selectedImage = UIImage(named: "icon_dashboard_selected")?.withRenderingMode(.alwaysOriginal)
        dashboardViewController.tabBarItem.title = DashboardViewController.TITLE
        // create navigation controller and put main view controller as root view
        let dashboardNavigationController: UINavigationController = UINavigationController(rootViewController: dashboardViewController)
        
        let clientViewController = ClientViewController()
        clientViewController.tabBarItem.image = UIImage(named: "icon_client_un_selected")?.withRenderingMode(.alwaysOriginal)
        clientViewController.tabBarItem.selectedImage = UIImage(named: "icon_client_selected")?.withRenderingMode(.alwaysOriginal)
        clientViewController.tabBarItem.title = ClientViewController.TITLE
        // create navigation controller and put main view controller as root view
        let clientNavigationController: UINavigationController = UINavigationController(rootViewController: clientViewController)
        
        let productViewController = ProductViewController()
        productViewController.tabBarItem.image = UIImage(named: "icon_product_un_selected")?.withRenderingMode(.alwaysOriginal)
        productViewController.tabBarItem.selectedImage = UIImage(named: "icon_product_selected")?.withRenderingMode(.alwaysOriginal)
        productViewController.tabBarItem.title = ProductViewController.TITLE
        // create navigation controller and put main view controller as root view
        let productNavigationController: UINavigationController = UINavigationController(rootViewController: productViewController)
        
        let orderViewController = OrderViewController()
        orderViewController.tabBarItem.image = UIImage(named: "icon_order_un_selected")?.withRenderingMode(.alwaysOriginal)
        orderViewController.tabBarItem.selectedImage = UIImage(named: "icon_order_selected")?.withRenderingMode(.alwaysOriginal)
        orderViewController.tabBarItem.title = OrderViewController.TITLE
        // create navigation controller and put main view controller as root view
        let orderNavigationController: UINavigationController = UINavigationController(rootViewController: orderViewController)
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem.image = UIImage(named: "icon_profile_un_selected")?.withRenderingMode(.alwaysOriginal)
        profileViewController.tabBarItem.selectedImage = UIImage(named: "icon_profile_selected")?.withRenderingMode(.alwaysOriginal)
        profileViewController.tabBarItem.title = ProfileViewController.TITLE
        // create navigation controller and put main view controller as root view
        let profileNavigationController: UINavigationController = UINavigationController(rootViewController: profileViewController)
        
        let tabBarController = UITabBarController()
        // tabBarController的主题颜色
        tabBarController.tabBar.tintColor = UIColor.init(red: 9/255.0, green: 187/255.0, blue: 7/255.0, alpha: 1)
        
        // 修改标签栏选中时文字颜色、字体
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)], for: .selected)
        
        // 修改标签栏未选中时文字颜色、字体
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)], for: .normal)
        
        // tabBarController的子视图控制器集合
        tabBarController.viewControllers = [
            dashboardNavigationController,
            clientNavigationController,
            productNavigationController,
            orderNavigationController,
            profileNavigationController
        ]
       
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()
    }
    
    /*
     UITabBarController通常最为整个程序的rootViewController，而且不能添加到别的视图控制器中，
     UITabBarController主要用来管理用户提供的包含各种内容的子视图控制器，
     而每一个子视图控制器则负责管理自己的视图层级关系。
     
     @1x : 推荐 25 x 25   (最大: 48 x 32)
     @2x : 推荐 50 x 50   (最大: 96 x 64)
     @3x : 推荐 75 x 75   (最大: 144 x 96)
     */
//    private func initBottomTabBar() {
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window!.backgroundColor = UIColor.white
//
//        let dashboardViewController = DashboardViewController()
//        dashboardViewController.tabBarItem.image = UIImage(named: "icon_dashboard_un_selected")?.withRenderingMode(.alwaysOriginal)
//        dashboardViewController.tabBarItem.selectedImage = UIImage(named: "icon_dashboard_selected")?.withRenderingMode(.alwaysOriginal)
//        dashboardViewController.tabBarItem.title = DashboardViewController.TITLE
//
//        let clientViewController = ClientViewController()
//        clientViewController.tabBarItem.image = UIImage(named: "icon_client_un_selected")?.withRenderingMode(.alwaysOriginal)
//        clientViewController.tabBarItem.selectedImage = UIImage(named: "icon_client_selected")?.withRenderingMode(.alwaysOriginal)
//        clientViewController.tabBarItem.title = ClientViewController.TITLE
//
//        let productViewController = ProductViewController()
//        productViewController.tabBarItem.image = UIImage(named: "icon_product_un_selected")?.withRenderingMode(.alwaysOriginal)
//        productViewController.tabBarItem.selectedImage = UIImage(named: "icon_product_selected")?.withRenderingMode(.alwaysOriginal)
//        productViewController.tabBarItem.title = ProductViewController.TITLE
//
//        let orderViewController = OrderViewController()
//        orderViewController.tabBarItem.image = UIImage(named: "icon_order_un_selected")?.withRenderingMode(.alwaysOriginal)
//        orderViewController.tabBarItem.selectedImage = UIImage(named: "icon_order_selected")?.withRenderingMode(.alwaysOriginal)
//        orderViewController.tabBarItem.title = OrderViewController.TITLE
//
//        let profileViewController = ProfileViewController()
//        profileViewController.tabBarItem.image = UIImage(named: "icon_profile_un_selected")?.withRenderingMode(.alwaysOriginal)
//        profileViewController.tabBarItem.selectedImage = UIImage(named: "icon_profile_selected")?.withRenderingMode(.alwaysOriginal)
//        profileViewController.tabBarItem.title = ProfileViewController.TITLE
//
//        let tabBarController = UITabBarController()
//        // tabBarController的主题颜色
//        tabBarController.tabBar.tintColor = UIColor.init(red: 9/255.0, green: 187/255.0, blue: 7/255.0, alpha: 1)
//
//        // 修改标签栏选中时文字颜色、字体
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)], for: .selected)
//
//        // 修改标签栏未选中时文字颜色、字体
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)], for: .normal)
//
//        // tabBarController的子视图控制器集合
//        tabBarController.viewControllers = [
//            dashboardViewController,
//            clientViewController,
//            productViewController,
//            orderViewController,
//            profileViewController
//        ]
//
//        // 添加到rootViewController
//        window?.rootViewController = tabBarController
//        window!.makeKeyAndVisible()
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

