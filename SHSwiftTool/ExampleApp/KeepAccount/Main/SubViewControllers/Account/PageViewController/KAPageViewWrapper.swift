//
//  KAPageViewWrapper.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class KAPageViewWrapper: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public var pageViewControllerItemArray: [UIViewController] = [UIViewController]()
    
    public var index = 0
    public var pageViewController: UIPageViewController!
    public var frame: CGRect!
    
    public func createPageViewController() {
       
        pageViewController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageViewController.setViewControllers([pageViewControllerItemArray[index]], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
    }
    
    // MARK: page view controller delegate
    // before
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! KAAccountListViewController
        var index = vc.index as Int
        
        if( index == 0 || index == NSNotFound) {
            return nil
        }
        index -= 1
        
        return pageViewControllerItemArray[index]
        
    }
    
    // after
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! KAAccountListViewController
        var index = vc.index as Int
        
        if(index == NSNotFound) {
            return nil
        }
        index += 1
        
        if(index == self.pageViewControllerItemArray.count){
            return nil
        }
        
        return pageViewControllerItemArray[index]
    }
    
    // completed
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            
            let currentViewController = pageViewController.viewControllers![0] as! KAAccountListViewController
            index = currentViewController.index
            
            ILog.debug(tag: #file, content: "current index \(index)")
            
//            let indexPath = IndexPath(row: index, section: 0)
            
//            tabLayout.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//            tabLayout.reloadData()
        }
    }
    // MARK: page view controller delegate
    
}
