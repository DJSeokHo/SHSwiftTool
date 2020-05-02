//
//  KAAccountDetailViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KAAccountDetailViewController: UIViewController, KANavigationBarViewHolderDelegate {

    public static let TAG = "KAAccountDetailViewController"
    
    private var kaNavigationBarViewHolder: KANavigationBarViewHolder!
    
    public var navigationBarTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view. 
        initNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: navigation bar
    private func initNavigationBar() {
        
        if kaNavigationBarViewHolder != nil {
            return
        }
        
        kaNavigationBarViewHolder = KANavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        kaNavigationBarViewHolder.kaNavigationBarViewHolderDelegate = self
        
        kaNavigationBarViewHolder.setTitle(title: navigationBarTitle)
        kaNavigationBarViewHolder.setRightButtonImage(imageName: "icon_close_black.png")
        kaNavigationBarViewHolder.hideLeftButton()
        
        ViewUtil.setShadow(view: kaNavigationBarViewHolder.bottomLine, color: UIColor.black.cgColor, radius: 1, opacity: 0.3, offsetWidth: 0, offsetHeight: 1)
        
        self.view.addSubview(kaNavigationBarViewHolder!)
    }
    func onLeftButtonClick() {
        ILog.debug(tag: #file, content: "onLeftButtonClick")
    }
    
    func onRightButtonClick() {
        ILog.debug(tag: #file, content: "onRightButtonClick")
        ViewControllerUtil.finishSelf(view:self)
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
