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
   
    @IBOutlet var rootView: UIView!
    @IBOutlet var tabLayoutContainer: UIView!
    @IBOutlet var viewPageContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        rootView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - CGFloat(KAConstants.BOTTOM_TAB_BAR_HEIGHT))
        
        initData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initNavigationBar()
        initTabLayout()
        initPageView()
    }
    
    private func initData() {
        
        currentIndex = 0
      
        tabLayoutTitleArray.removeAll()
        tabLayoutTitleArray.append(KAConstants.CATEGORY_OTHER)
        tabLayoutTitleArray.append(KAConstants.CATEGORY_SHOPPING)
        tabLayoutTitleArray.append(KAConstants.CATEGORY_RESTAURANT)
        tabLayoutTitleArray.append(KAConstants.CATEGORY_CULTURAL)
        tabLayoutTitleArray.append(KAConstants.CATEGORY_TRAVEL)
        tabLayoutTitleArray.append(KAConstants.CATEGORY_MEDICAL)
        tabLayoutTitleArray.append(KAConstants.CATEGORY_STUDY)
        
        
        for index in 0..<tabLayoutTitleArray.count {
            
            let kaAccountListViewController = KAAccountListViewController()
            kaAccountListViewController.index = index
            kaAccountListViewController.category = tabLayoutTitleArray[index]
            pageViewControllerItemArray.append(kaAccountListViewController)
        }
    }
    
    private func initTabLayout() {
        
        if tabLayout != nil {
            return
        }
        
        tabLayoutContainer.frame = CGRect(x: 0, y: 80, width: tabLayoutContainer.frame.width, height: 30)
        
        tabLayout = KATabLayout()
        
        tabLayout.onTabSelect = {
            (_ index: Int) in
            if self.pageViewWrapper == nil || self.tabLayout == nil {
                return
            }
            
            ILog.debug(tag: #file, content: "here ??? onTabSelect")
            let indexPath: IndexPath = IndexPath(row: index, section: 0)

            self.tabLayout.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            self.tabLayout.collectionView.reloadData()
            
            let viewController = self.pageViewControllerItemArray[index]

            if index > self.currentIndex {
                self.pageViewWrapper.pageViewController.setViewControllers([viewController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
            }
            else {
                self.pageViewWrapper.pageViewController.setViewControllers([viewController], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
            }

            self.currentIndex = index
            self.tabLayout.index = self.currentIndex
        }
        
        tabLayout.titleArray.append(contentsOf: tabLayoutTitleArray)
        
        tabLayout.frame = CGRect(x: 0, y: 0, width: tabLayoutContainer.frame.width, height: 30)
        tabLayout.index = currentIndex
        
        tabLayout.initTabLayout()
        
        tabLayoutContainer.addSubview(tabLayout.collectionView)
    }
    
    private func initPageView() {
     
        if pageViewWrapper != nil {
            return
        }
        
        viewPageContainer.frame = CGRect(x: 0, y: 110, width: rootView.frame.width, height: rootView.frame.height - 110)
        
        pageViewWrapper = KAPageViewWrapper()
        
        pageViewWrapper.onPageSelectFinished = {
            (_ index: Int) in
            
            if self.pageViewWrapper == nil || self.tabLayout == nil {
                return
            }
            
            self.currentIndex = index
            self.tabLayout.index = self.currentIndex
            
            let indexPath = IndexPath(row: self.currentIndex, section: 0)
            self.tabLayout.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            self.tabLayout.collectionView.reloadData()
        }
        
        pageViewWrapper.pageViewControllerItemArray.append(contentsOf: pageViewControllerItemArray)
        pageViewWrapper.index = currentIndex
        
        pageViewWrapper.frame = CGRect(x: 0, y: 0, width: viewPageContainer.frame.size.width, height: viewPageContainer.frame.size.height)
        
        pageViewWrapper.createPageViewController()
        pageViewWrapper.pageViewController.view.frame = CGRect(x: 0, y: 0, width: viewPageContainer.frame.size.width, height: viewPageContainer.frame.size.height)
        
        self.addChild(pageViewWrapper.pageViewController)
        viewPageContainer.addSubview(pageViewWrapper.pageViewController.view)
        pageViewWrapper.pageViewController.didMove(toParent: self)
    }
    
    
    // MARK: navigation bar
    private func initNavigationBar() {
        
        if kaNavigationBarViewHolder != nil {
            return
        }
        
        kaNavigationBarViewHolder = KANavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: rootView.frame.width, height: 80))
      
        kaNavigationBarViewHolder.setTitle(title: "Record")
        kaNavigationBarViewHolder.hideRightButton()
        kaNavigationBarViewHolder.hideLeftButton()
        
        ViewUtil.setShadow(view: kaNavigationBarViewHolder.bottomLine, color: UIColor.black.cgColor, radius: 1, opacity: 0.3, offsetWidth: 0, offsetHeight: 1)
        
        rootView.addSubview(kaNavigationBarViewHolder!)
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
