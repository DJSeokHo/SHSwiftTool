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
    }
    
    @objc private func onButtonLoginTemplateClicked(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonLoginTemplateClicked")
        
        let loginHomeViewController = LoginHomeViewController();
        
        // create navigation controller and put main view controller as root view
        let navigationController: UINavigationController = UINavigationController(rootViewController: loginHomeViewController)
        
        // make navigation controller as window root view controller
        //        self.window!.rootViewController = navigationController
        
        self.present(navigationController, animated: true, completion: nil)
        
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
