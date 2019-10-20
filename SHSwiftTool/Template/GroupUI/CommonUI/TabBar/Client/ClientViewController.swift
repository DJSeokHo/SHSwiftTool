//
//  ClientViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 21/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class ClientViewController: UIViewController, NavigationBarViewHolderDelegate {

    private static let TAG = "ClientViewController"
    
    public static let TITLE = "Client"
    
    private var navigationBarViewHolder: NavigationBarViewHolder?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
    
    private func initNavigationBar() {
        
        if(navigationBarViewHolder == nil) {
            navigationBarViewHolder = NavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
            navigationBarViewHolder!.setTitle(title: ClientViewController.TITLE)
            navigationBarViewHolder!.hideRightButton()
            navigationBarViewHolder!.hideLeftButton()
            
            navigationBarViewHolder!.setDelegate(navigationBarViewHolderDelegate: self)
            
            self.view.addSubview(navigationBarViewHolder!)
        }
    }
    
    func onButtonLeftClicked() {
        ILog.debug(tag: ClientViewController.TAG, content: "onButtonLeftClicked")
    }
    
    func onButtonRightClicked() {
        ILog.debug(tag: ClientViewController.TAG, content: "onButtonRightClicked")
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
