//
//  MainViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 21/06/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private static let TAG = "MainViewController"
    
    private var navigationBarViewHolder: NavigationBarViewHolder?
    
    public var width: CGFloat?
    
    @IBOutlet var buttonBasicUIViewController: UIButton!
    @IBOutlet var buttonBasicNavigationController: UIButton!
    @IBOutlet var buttonLogin: UIButton!
    @IBOutlet var buttonCamera: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ILog.debug(tag: MainViewController.TAG, content: "viewDidLoad")
        basicConsoleTest()
        
        setListener()
    
    }
    
    private func setListener() {
        buttonBasicUIViewController.addTarget(self, action: #selector(self.onButtonBasicUIViewControllerClick(_:)), for: UIControl.Event.touchUpInside)

        buttonBasicNavigationController.addTarget(self, action: #selector(self.onButtonBasicNavigationControllerClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonLogin.addTarget(self, action: #selector(self.onButtonLoginClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonCamera.addTarget(self, action: #selector(self.onButtonCameraClick(_:)), for: UIControl.Event.touchUpInside)
    }
    
    /*
     go to basic ui view controller template
     */
    @objc private func onButtonBasicUIViewControllerClick(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonBasicUIViewControllerClick")
        
        let basicUIViewController = BasicUIViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicUIViewController)
    }
    
    /*
     go to basic navigation controller template
     */
    @objc private func onButtonBasicNavigationControllerClick(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonBasicNavigationControllerClick")
        
        let navigationRootViewController = NavigationRootViewController()
        ViewControllerUtil.startNewViewControllerWithNavigation(from: self, target: navigationRootViewController)
    }
    
    @objc private func onButtonLoginClick(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonLoginClick")
        
        let loginHomeViewController = LoginHomeViewController()
        loginHomeViewController.fromWhere = "From \(MainViewController.TAG)"
        
        ViewControllerUtil.startNewViewControllerWithNavigation(from: self, target: loginHomeViewController)
    }
    
    @objc private func onButtonCameraClick(_ sender: UIButton) {
        let cameraViewController = CameraViewController()
        cameraViewController.width = self.view.frame.width
        ViewControllerUtil.startNewViewController(from: self, target: cameraViewController)
    }
    
    private func basicConsoleTest() {
        showPaths()

//        let basicConsoleTest = BasicConsoleTest()
//        basicConsoleTest.basicGrammarTest()
//        basicConsoleTest.basicStringTest()
//        basicConsoleTest.basicCollectionTest()
//        basicConsoleTest.basicControlFlowTest()
//        basicConsoleTest.basicFunctionTest()
//        basicConsoleTest.basicClassAndStruct()
//        basicConsoleTest.basicInherit()
//        basicConsoleTest.basicFoundation()
    }
   
    private func showPaths() {
        StorageUtil.getAppSandBoxDirectory()
        StorageUtil.getDocumentDirectory()
        StorageUtil.getTempDirectory()
        StorageUtil.getLibraryDirectory()
        StorageUtil.getLibraryCachesDirectory()
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
