//
//  SettingViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/29.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, SimpleNavigationBarViewHolderDelegate {
    
    private static let TAG = "SettingViewController"
    
    @IBOutlet var imageViewDoneList: UIImageView!
    @IBOutlet var labelDoneList: UILabel!
   
    @IBOutlet var viewRoot: UIView!
    
    private var simpleNavigationBarViewHolder: SimpleNavigationBarViewHolder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        initNavigationBar()
        setListener()
        
        
        let screenSize = DisplayUtil.getFullScreenSize()
        viewRoot.frame = CGRect(x: 0, y: 80, width: screenSize.width, height: screenSize.height - 80)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    private func setListener() {
        
        TapUtil.addTapListener(viewGroup: self, target: labelDoneList, action: #selector(onDoneListClick))
        
    }
    
    private func initNavigationBar() {
        
        simpleNavigationBarViewHolder = SimpleNavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        
        simpleNavigationBarViewHolder.simpleNavigationBarViewHolderDelegate = self
        
        simpleNavigationBarViewHolder.setTitle(title: "Setting")
        
        self.view.addSubview(simpleNavigationBarViewHolder!)
    }
    
    func onButtonBackClicked() {
        NavigationUtil.navigationToPrev(from: self, animated: true)
    }
    
    @objc private func onDoneListClick(_ sender: UIButton) {
         ILog.debug(tag: SettingViewController.TAG , content: "onDoneListClick")
        
        let doneListViewController: DoneListViewController = DoneListViewController()
        NavigationUtil.navigationToNext(from: self, target: doneListViewController, animated: true)
    }
    
    deinit {
        ILog.debug(tag: SettingViewController.TAG , content: "deinit")
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
