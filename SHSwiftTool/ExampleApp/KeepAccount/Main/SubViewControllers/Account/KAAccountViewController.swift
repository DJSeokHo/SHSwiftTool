//
//  KAAccountViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/30.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KAAccountViewController: UIViewController {
    
    public let tag = "KAAccountViewController"
    public static let TAG = "KAAccountViewController"
    
    private var kaNavigationBarViewHolder: KANavigationBarViewHolder!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        initNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: navigation bar
    private func initNavigationBar() {
        
        kaNavigationBarViewHolder = KANavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
      
        kaNavigationBarViewHolder.setTitle(title: "Record")
        kaNavigationBarViewHolder.hideRightButton()
        kaNavigationBarViewHolder.hideLeftButton()
        
        ViewUtil.setShadow(view: kaNavigationBarViewHolder.bottomLine, color: UIColor.black.cgColor, radius: 3, opacity: 0.5, offsetWidth: 0, offsetHeight: 3)
        
        self.view.addSubview(kaNavigationBarViewHolder!)
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
