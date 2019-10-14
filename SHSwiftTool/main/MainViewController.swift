//
//  MainViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 21/06/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, NavigationBarViewHolderDelegate {
    
    private static let TAG = "MainViewController"
    
    private var navigationBarViewHolder: NavigationBarViewHolder?
    
    public var width: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ILog.debug(tag: MainViewController.TAG, content: "viewDidLoad")
        
        showPaths()
        
        let basicConsoleTest = BasicConsoleTest()
//        basicConsoleTest.basicGrammarTest()
//        basicConsoleTest.basicStringTest()
//        basicConsoleTest.basicCollectionTest()
//        basicConsoleTest.basicControlFlowTest()
//        basicConsoleTest.basicFunctionTest()
//        basicConsoleTest.basicClassAndStruct()
//        basicConsoleTest.basicInherit()
        basicConsoleTest.basicFoundation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
    
    private func showPaths() {
        StorageUtil.getAppSandBoxDirectory()
        StorageUtil.getDocumentDirectory()
        StorageUtil.getTempDirectory()
        StorageUtil.getLibraryDirectory()
        StorageUtil.getLibraryCachesDirectory()
    }
    
    private func initNavigationBar() {
        
        if(navigationBarViewHolder == nil) {
            navigationBarViewHolder = NavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.width!, height: 80))
            navigationBarViewHolder!.setTitle(title: "Main")
            navigationBarViewHolder!.setRightButtonImage(imageName: "icon_close.png")
            navigationBarViewHolder!.hideLeftButton()
            
            navigationBarViewHolder!.setDelegate(navigationBarViewHolderDelegate: self)
            
            self.view.addSubview(navigationBarViewHolder!)
        }
    }
    
    private func removeNavigationBar() {
        if(navigationBarViewHolder != nil) {
            ILog.debug(tag: MainViewController.TAG, content: "removeNavigationBar")
            navigationBarViewHolder?.removeFromSuperview()
            navigationBarViewHolder = nil;
        }
    }
    
    
    func onButtonLeftClicked() {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonLeftCLicked")
    }
    
    func onButtonRightClicked() {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonRightClicked")
        ViewControllerUtil.finishSelf(view: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        removeNavigationBar()
    }

    deinit {
        ILog.debug(tag: MainViewController.TAG, content: "deinit")
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
