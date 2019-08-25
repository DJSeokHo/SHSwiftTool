//
//  TemplateTestViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 22/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class TemplateTestViewController: UIViewController, NavigationBarViewHolderDelegate {

    private static let TAG = "TemplateTestViewController"
    
    private var navigationBarViewHolder: NavigationBarViewHolder?
    
    @IBOutlet var buttonLoginTemplate: UIButton!
    @IBOutlet var buttonGoToMain: UIButton!
    @IBOutlet var buttonCamera: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        // Do any additional setup after loading the view.
        setListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
    
    private func initNavigationBar() {
        
        if(navigationBarViewHolder == nil) {
            navigationBarViewHolder = NavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
            navigationBarViewHolder!.setTitle(title: "Template Test")
            navigationBarViewHolder!.setRightButtonImage(imageName: "icon_close.png")
            navigationBarViewHolder!.hideLeftButton()
            
            navigationBarViewHolder!.setDelegate(navigationBarViewHolderDelegate: self)
            
            self.view.addSubview(navigationBarViewHolder!)
        }
    }
    
    private func removeNavigationBar() {
        if(navigationBarViewHolder != nil) {
            ILog.debug(tag: TemplateTestViewController.TAG, content: "removeNavigationBar")
            navigationBarViewHolder?.removeFromSuperview()
            navigationBarViewHolder = nil;
        }
    }
    
    func onButtonLeftClicked() {
        ILog.debug(tag: TemplateTestViewController.TAG, content: "onButtonLeftClicked")
    }
    
    func onButtonRightClicked() {
        ILog.debug(tag: TemplateTestViewController.TAG, content: "onButtonRightClicked")
        ViewControllerUtil.finishSelf(view: self)
    }
    
    private func setListener() {
        self.buttonLoginTemplate.addTarget(self, action: #selector(self.onButtonLoginTemplateClicked(_:)), for: UIControl.Event.touchUpInside)
        
        self.buttonGoToMain.addTarget(self, action: #selector(self.onButtonGoToMainClicked(_:)), for: UIControl.Event.touchUpInside)
        
        self.buttonCamera.addTarget(self, action: #selector(self.onButtonCameraClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonCameraClicked(_ sender: UIButton) {
        let cameraViewController = CameraViewController()
        cameraViewController.width = self.view.frame.width
        ViewControllerUtil.startNewViewController(from: self, target: cameraViewController)
    }
    
    @objc private func onButtonGoToMainClicked(_ sender: UIButton) {
        let mainViewController = MainViewController()
        mainViewController.width = self.view.frame.width
        ViewControllerUtil.startNewViewController(from: self, target: mainViewController)
    }
    
    @objc private func onButtonLoginTemplateClicked(_ sender: UIButton) {
        ILog.debug(tag: TemplateTestViewController.TAG, content: "onButtonLoginTemplateClicked")
        
        let loginHomeViewController = LoginHomeViewController()
        loginHomeViewController.fromWhere = "From \(TemplateTestViewController.TAG)"
        
        ViewControllerUtil.startNewViewControllerWithNavigation(from: self, target: loginHomeViewController)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeNavigationBar()
    }
    
    
    deinit {
        ILog.debug(tag: TemplateTestViewController.TAG, content: "deinit")
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
