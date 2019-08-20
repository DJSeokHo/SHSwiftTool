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
    
    @IBOutlet var buttonLoginTemplate: UIButton!
    @IBOutlet var buttonTabBarTemplate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ILog.debug(tag: MainViewController.TAG, content: "viewDidLoad")
        setListener()
        
//        let basicConsoleTest = BasicConsoleTest()
//        basicConsoleTest.basicGrammarTest()
//        basicConsoleTest.basicStringTest()
//        basicConsoleTest.basicCollectionTest()
//        basicConsoleTest.basicControlFlowTest()
//        basicConsoleTest.basicFunctionTest()
//        basicConsoleTest.basicClassAndStruct()
//        basicConsoleTest.basicInherit()
    }
    

    private func setListener() {
        self.buttonLoginTemplate.addTarget(self, action: #selector(self.onButtonLoginTemplateClicked(_:)), for: UIControl.Event.touchUpInside)
        
        self.buttonTabBarTemplate.addTarget(self, action: #selector(self.onButtonTabBarTemplateClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonTabBarTemplateClicked(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonTabBarTemplateClicked")
        
    }
    
    @objc private func onButtonLoginTemplateClicked(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonLoginTemplateClicked")
        
        let loginHomeViewController = LoginHomeViewController()
        loginHomeViewController.fromWhere = "From \(MainViewController.TAG)"
        
        ViewControllerUtil.startNewViewControllerWithNavigation(from: self, target: loginHomeViewController)
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
