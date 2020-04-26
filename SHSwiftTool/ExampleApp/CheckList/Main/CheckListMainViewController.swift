//
//  CheckListMainViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/27.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit
class CheckListMainViewController: UIViewController, CheckListMainNavigationBarViewHolderDelegate {
   
    private static let TAG = "CheckListMainViewController"

    private var checkListMainNavigationBarViewHolder: CheckListMainNavigationBarViewHolder!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewInputArea: UIView!
    @IBOutlet var buttonPlus: UIButton!
    @IBOutlet var textView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        setListener()
        
        CLDBWrapper.getInstance().initDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
        initInputArea();
        initTableView();
    }
    
    private func setListener() {
        buttonPlus.addTarget(self, action: #selector(onButtonPlusClick), for: UIControl.Event.touchUpInside)
        SoftKeyboardUtil.tapSpaceToCloseSoftKeyboard(target: self, action: #selector(hideKeyboard))
    }
    
    @objc private func onButtonPlusClick(_ sender: UIButton) {
        
        if textView.text == nil || textView.text == "" {
            return
        }
        
        ILog.debug(tag: CheckListMainViewController.TAG, content: "onButtonPlusClick")
        hideKeyboard()
        addCheckInfo()
        
        textView.text = ""
    }
    
    @objc func hideKeyboard() {
        
        // 除了用 self.view.endEditing(true)
        // 也可以用 resignFirstResponder()
        textView.resignFirstResponder()
    }
    
    private func addCheckInfo() {
        
        let checkInfoBean = CheckInfoBean(uuid: UUIDUtil.getUUID(), content: self.textView.text!, dateTime: DateUtil.getCurrentDateTimeStringWithStandardSQLiteDateTimeFromatter(), done: "N")
        
        ILog.debug(tag: CheckListMainViewController.TAG, content: checkInfoBean.toString()!)
        
        CLDBWrapper.getInstance().insert(checkInfoBean: checkInfoBean)
    }

    private func initData() {
    
    }
    
    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 140, width: self.view.frame.width, height: self.view.frame.height - 140)
    }
    
    private func initNavigationBar() {
        
        checkListMainNavigationBarViewHolder = CheckListMainNavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        
        checkListMainNavigationBarViewHolder.checkListMainNavigationBarViewHolderDelegate = self
        self.view.addSubview(checkListMainNavigationBarViewHolder!)
       
    }
    
    private func initInputArea() {
        viewInputArea.frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: 60)
    }
    
    // navigation bar delegate
    func onButtonEditClicked() {
        ILog.debug(tag: CheckListMainViewController.TAG, content: "onButtonEditClicked")
    }

    // navigation bar delegate
    func onButtonMoreClicked() {
         ILog.debug(tag: CheckListMainViewController.TAG, content: "onButtonMoreClicked")
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
