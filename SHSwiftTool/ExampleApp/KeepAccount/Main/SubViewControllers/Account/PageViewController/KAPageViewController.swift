//
//  KAPageViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class KAPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private let tag = "KAPageViewController"
    
    private(set) lazy var allViewControllers: [UIViewController] = {
        return [KAAccountListViewController(),
                KAAccountListViewController(),
                KAAccountListViewController()]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let firstViewController = allViewControllers.first
        
        setViewControllers([firstViewController!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }
    
    
    
    // MARK: page view controller delegate
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var viewControllerIndex: Int = 0
        
        for index in 0..<allViewControllers.count {
            if allViewControllers[index] == viewController {
                viewControllerIndex = index
                break
            }
        }
        
         
        let previousIndex = viewControllerIndex - 1
         
        guard previousIndex >= 0 else {
            return nil
        }
         
        guard allViewControllers.count > previousIndex else {
            return nil
        }
         
        return allViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var viewControllerIndex: Int = 0
        
        for index in 0..<allViewControllers.count {
            if allViewControllers[index] == viewController {
                viewControllerIndex = index
                break
            }
        }
        
         
        let previousIndex = viewControllerIndex + 1
         
        guard previousIndex >= 0 else {
            return nil
        }
         
        guard allViewControllers.count > previousIndex else {
            return nil
        }
         
        return allViewControllers[previousIndex]
    }
    // MARK: page view controller delegate
    
}
