//
//  CheckListMainViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/27.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit
class CheckListMainViewController: UIViewController, CheckListMainNavigationBarViewHolderDelegate {
   
    public static let TAG = "CheckListMainViewController"

    private var checkListMainNavigationBarViewHolder: CheckListMainNavigationBarViewHolder!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewInputArea: UIView!
    @IBOutlet var buttonPlus: UIButton!
    @IBOutlet var textView: UITextField!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    private var refreshControl: UIRefreshControl!
    
    public var checkInfoBeanList: [CheckInfoBean] = [CheckInfoBean]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        initObserver()
        initNavigationBar()
        initInputArea();
        initTableView();
        
        setListener()
        
        CLDBWrapper.getInstance().initDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        reloadData();
    }
    
    private func initObserver() {
        
        NotificationUtil.addObserver(observer: self, selector: #selector(observerEditCheckListItem(notfication:)), name: CLNotificationConstants.REQUEST_EDIT_LIST_ITEM)
    }
    @objc func observerEditCheckListItem(notfication: NSNotification) {
        ILog.debug(tag: CheckListMainViewController.TAG, content: "observerEditCheckListItem")
        
        let userInfo = notfication.userInfo
        let checkInfoBean = userInfo!["checkInfoBean"] as! CheckInfoBean
       
        ILog.debug(tag: CheckListMainViewController.TAG, content: checkInfoBean.toString()!)
        
        AlertViewUtil.showTwoButtonWithOneInputAlertView(from: self, setTitle: "Editing", setMessage: "Change content", setInputPlaceHolder: "input content", setContent: checkInfoBean.content, setConfirmButtonTitle: "Confirm", setCancelButtonTitle: "Cancel", setConfirmDelegate: {newContent in
            ILog.debug(tag: CheckListMainViewController.TAG, content: newContent)
            
            let newCheckInfoBean = CheckInfoBean(uuid: checkInfoBean.uuid, content: newContent, dateTime: checkInfoBean.dateTime, done: checkInfoBean.done)
            self.updateData(checkInfoBean: newCheckInfoBean)
        })
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
        
        insertData()
        
        textView.text = ""
    }
    
    @objc func hideKeyboard() {
        
        // 除了用 self.view.endEditing(true)
        // 也可以用 resignFirstResponder()
        textView.resignFirstResponder()
    }

    public func reloadData() {
        
        showProgress()
        
        ThreadUtil.startThread {
            
            var checkInfoList: [CheckInfoBean] = [CheckInfoBean]()
            checkInfoList.append(contentsOf: CLDBWrapper.getInstance().getDataArray(offset: "0", limit: "10"))
           
            ThreadUtil.startUIThread(runnable: {
                
                self.reload(checkInfoBeanList: checkInfoList)
                self.hideProgress()
                
            }, after: 0)
        }
    }
    
    public func loadMoreData() {
        
        showProgress()
        
        ThreadUtil.startThread {
            
            var checkInfoList: [CheckInfoBean] = [CheckInfoBean]()
            checkInfoList.append(contentsOf: CLDBWrapper.getInstance().getDataArray(offset: String(self.getItemCount()), limit: "10"))
           
            ThreadUtil.startUIThread(runnable: {
                
                self.loadMore(checkInfoBeanList: checkInfoList)
                self.hideProgress()
                
            }, after: 0)
        }
    }
    
    public func insertData() {
        
        showProgress()
        
        let content = self.textView.text!
        
        ThreadUtil.startThread {
        
            let checkInfoBean = CheckInfoBean(uuid: UUIDUtil.getUUID(), content: content, dateTime: DateUtil.getCurrentDateTimeStringWithStandardSQLiteDateTimeFromatter(), done: "N")
            
            ILog.debug(tag: CheckListMainViewController.TAG, content: checkInfoBean.toString()!)
            
            CLDBWrapper.getInstance().insert(checkInfoBean: checkInfoBean)
            
            ThreadUtil.startUIThread(runnable: {
                
                self.insertToFront(checkInfoBean: checkInfoBean)
                self.hideProgress()
                
            }, after: 0)
        }
    }
    
    public func deleteData(checkInfoBean: CheckInfoBean) {
        
        showProgress()
        
        ThreadUtil.startThread {
        
            CLDBWrapper.getInstance().deleteData(checkInfoBean: checkInfoBean)
            
            ThreadUtil.startUIThread(runnable: {
                
                self.delete(checkInfoBean: checkInfoBean)
                self.hideProgress()
                
            }, after: 0)
        }
    }
    
    public func updateData(checkInfoBean: CheckInfoBean) {
        showProgress()
        
        ThreadUtil.startThread {
        
            CLDBWrapper.getInstance().updateData(checkInfoBean: checkInfoBean)
            
            ThreadUtil.startUIThread(runnable: {
                
                self.update(checkInfoBean: checkInfoBean)
                self.hideProgress()
                
            }, after: 0)
        }
    }
    
    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 140, width: self.view.frame.width, height: self.view.frame.height - 140)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
        
        tableView.register(UINib(nibName: CheckListItemTableViewCell.TAG, bundle: nil), forCellReuseIdentifier: CheckListItemTableViewCell.TAG)
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        ILog.debug(tag: CheckListMainViewController.TAG, content: "reload")
        
        refreshControl.endRefreshing()
        
        reloadData()
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
    
    private func showProgress() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    private func hideProgress() {
        indicator.stopAnimating()
        indicator.isHidden = true
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
