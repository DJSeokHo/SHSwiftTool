//
//  CameraViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 25/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, NavigationBarViewHolderDelegate {
   
    
    private static let TAG = "CameraViewController"
    
    @IBOutlet var buttonCamera: UIButton!
    
    public var width:CGFloat?
    private var navigationBarViewHolder: NavigationBarViewHolder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
    
    private func initNavigationBar() {
        
        if(navigationBarViewHolder == nil) {
            navigationBarViewHolder = NavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: width!, height: 80))
            navigationBarViewHolder!.setTitle(title: "Camera")
            navigationBarViewHolder!.setRightButtonImage(imageName: "icon_close.png")
            navigationBarViewHolder!.hideLeftButton()
            
            navigationBarViewHolder!.setDelegate(navigationBarViewHolderDelegate: self)
            
            self.view.addSubview(navigationBarViewHolder!)
        }
    }
    
    private func removeNavigationBar() {
        if(navigationBarViewHolder != nil) {
            ILog.debug(tag: CameraViewController.TAG, content: "removeNavigationBar")
            navigationBarViewHolder?.removeFromSuperview()
            navigationBarViewHolder = nil;
        }
    }
    
    private func setListener() {
        self.buttonCamera.addTarget(self, action: #selector(self.onButtonCameraClicked(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func onButtonCameraClicked(_ sender: UIButton) {
        ILog.debug(tag: CameraViewController.TAG, content: "onButtonCameraClicked")
    }

    func onButtonLeftClicked() {
        
    }
    
    func onButtonRightClicked() {
        ViewControllerUtil.finishSelf(view: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeNavigationBar()
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
