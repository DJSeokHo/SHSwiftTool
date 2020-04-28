//
//  DoneListViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/29.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class DoneListViewController: UIViewController, SimpleNavigationBarViewHolderDelegate {
    
    public static let TAG = "DoneListViewController"

    private var simpleNavigationBarViewHolder: SimpleNavigationBarViewHolder!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    private var refreshControl: UIRefreshControl!
    
    public var checkInfoBeanList: [CheckInfoBean] = [CheckInfoBean]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        initObserver()
        initNavigationBar()
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        reloadData();
    }

    private func initObserver() {
        
        NotificationUtil.addObserver(observer: self, selector: #selector(observerUnFinishCheckListItem(notfication:)), name: CLNotificationConstants.REQUEST_UN_FINISH_LIST_ITEM)
        
    }
    @objc func observerUnFinishCheckListItem(notfication: NSNotification) {
        ILog.debug(tag: DoneListViewController.TAG, content: "observerUnFinishCheckListItem")
        
        let userInfo = notfication.userInfo
        let checkInfoBean = userInfo!["checkInfoBean"] as! CheckInfoBean
       
        ILog.debug(tag: CheckListMainViewController.TAG, content: checkInfoBean.toString()!)
       
        checkInfoBean.done = "N"
        checkInfoBean.dateTime = DateUtil.getCurrentDateTimeStringWithStandardSQLiteDateTimeFromatter()
        
        showProgress()
        
        ThreadUtil.startThread {
        
            CLDBWrapper.getInstance().updateData(checkInfoBean: checkInfoBean)
            
            ThreadUtil.startUIThread(runnable: {
                
                self.delete(checkInfoBean: checkInfoBean)
                self.hideProgress()
                
            }, after: 0)
        }
    }
    
    private func initNavigationBar() {
        
        simpleNavigationBarViewHolder = SimpleNavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        
        simpleNavigationBarViewHolder.simpleNavigationBarViewHolderDelegate = self
        
        simpleNavigationBarViewHolder.setTitle(title: "Done List")
        
        self.view.addSubview(simpleNavigationBarViewHolder!)
    }
    
    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: self.view.frame.height - 80)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
        
        tableView.register(UINib(nibName: DoneListItemTableViewCell.TAG, bundle: nil), forCellReuseIdentifier: DoneListItemTableViewCell.TAG)
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        ILog.debug(tag: DoneListViewController.TAG, content: "reload")
        
        refreshControl.endRefreshing()
        
        reloadData()
    }
    
    public func reloadData() {
        
        showProgress()
        
        ThreadUtil.startThread {
            
            var checkInfoList: [CheckInfoBean] = [CheckInfoBean]()
            checkInfoList.append(contentsOf: CLDBWrapper.getInstance().getDataArray(offset: "0", limit: "10", isDone: "Y"))
           
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
            checkInfoList.append(contentsOf: CLDBWrapper.getInstance().getDataArray(offset: String(self.getItemCount()), limit: "10", isDone: "Y"))
           
            ThreadUtil.startUIThread(runnable: {
                
                self.loadMore(checkInfoBeanList: checkInfoList)
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

    private func showProgress() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    private func hideProgress() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    func onButtonBackClicked() {
        NavigationUtil.navigationToPrev(from: self, animated: true)
    }
    
    deinit {
        NotificationUtil.removeAllObserver(observer: self)
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
