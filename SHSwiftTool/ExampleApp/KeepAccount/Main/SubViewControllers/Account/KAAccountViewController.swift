//
//  KAAccountViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/30.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KAAccountViewController: UIViewController {
    
    public static let TAG = "KAAccountViewController"
    
    private var kaNavigationBarViewHolder: KANavigationBarViewHolder!
    
    private var tabLayout: KATabLayout!
    private var pageViewWrapper: KAPageViewWrapper!
    
    private var currentIndex: Int!
    
    private var tabLayoutTitleArray: [String] = [String]()
    private var pageViewControllerItemArray: [UIViewController] = [UIViewController]()
   
    @IBOutlet var tabLayoutContainer: UIView!
    @IBOutlet var viewPageContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        
        initData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initNavigationBar()
//        initTabLayout()
        initPageView()
    }
    
    private func initData() {
        
        currentIndex = 0
        
        for index in 0..<10 {
            
            let kaAccountListViewController = KAAccountListViewController()
            kaAccountListViewController.index = index
            pageViewControllerItemArray.append(kaAccountListViewController)
            
            tabLayoutTitleArray.append("page \(index)")
        }
    }
    
    private func initTabLayout() {
        
        if tabLayout != nil {
            return
        }
        
        tabLayoutContainer.frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: 30)
        
        tabLayout = KATabLayout()
        tabLayout.frame = CGRect(x: 0, y: 60, width: DisplayUtil.getFullScreenSize().width, height: 30)
        tabLayout.titleArray.append(contentsOf: tabLayoutTitleArray)
        tabLayout.index = currentIndex
        tabLayout.initTabLayout()
        
        tabLayoutContainer.addSubview(tabLayout.collectionView)
    }
    
    private func initPageView() {
     
        if pageViewWrapper != nil {
            return
        }
        
        viewPageContainer.frame = CGRect(x: 0, y: 110, width: self.view.frame.width, height: self.view.frame.height - 110)
        
        pageViewWrapper = KAPageViewWrapper()
        pageViewWrapper.pageViewControllerItemArray.append(contentsOf: pageViewControllerItemArray)
        pageViewWrapper.index = currentIndex
        pageViewWrapper.frame = CGRect(x: 0, y: 0, width: viewPageContainer.frame.size.width, height: viewPageContainer.frame.size.height)
        
        pageViewWrapper.createPageViewController()
        
        self.addChild(pageViewWrapper.pageViewController)
        viewPageContainer.addSubview(pageViewWrapper.pageViewController.view)
        pageViewWrapper.pageViewController.didMove(toParent: self)
    }
    
    // MARK: navigation bar
    private func initNavigationBar() {
        
        if kaNavigationBarViewHolder != nil {
            return
        }
        
        kaNavigationBarViewHolder = KANavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
      
        kaNavigationBarViewHolder.setTitle(title: "Record")
        kaNavigationBarViewHolder.hideRightButton()
        kaNavigationBarViewHolder.hideLeftButton()
        
        ViewUtil.setShadow(view: kaNavigationBarViewHolder.bottomLine, color: UIColor.black.cgColor, radius: 3, opacity: 0.5, offsetWidth: 0, offsetHeight: 3)
        
        self.view.addSubview(kaNavigationBarViewHolder!)
    }
   
    // MARK: navigation bar
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
