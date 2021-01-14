//
//  KAAccountListViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KAAccountListViewController: UIViewController {

    public var index = 0
    public var category = KAConstants.CATEGORY_OTHER
    
    @IBOutlet var labelNoData: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    private var kaAccountListAdapter: KAAccountListAdapter!
    private var refreshControl: UIRefreshControl!
    
    public var keepAccountInfoBeanArray: [KeepAccountInfoBean] = [KeepAccountInfoBean]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initObserver()
        hideProgress()
        initTableView()
        reloadData()
    }
    
    private func initObserver() {
        
        NotificationUtil.addObserver(name: KANotificationConstants.REQUEST_REFRESH_LIST, observer: self, selector: #selector(observerRefreshList))
    }
    
    @objc func observerRefreshList(notfication: NSNotification) {
     
        reloadData()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func initTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

        tableView.register(UINib(nibName: KAAccountListItemTableViewCell.TAG, bundle: nil), forCellReuseIdentifier: KAAccountListItemTableViewCell.TAG)

        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false

        refreshControl = UIRefreshControl()

        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        kaAccountListAdapter = KAAccountListAdapter()

        tableView.delegate = kaAccountListAdapter
        tableView.dataSource = kaAccountListAdapter

        kaAccountListAdapter.itemHeight = 112
        kaAccountListAdapter.sectionNumber = 1
        kaAccountListAdapter.needLoadMore = true
        kaAccountListAdapter.canRowEdit = false

        kaAccountListAdapter.loadMoreDelegate = {
          self.loadMoreData()
        }

        kaAccountListAdapter.noDataDelegate = {
            (noData: Bool) in
            self.labelNoData.isHidden = !noData
        }
    }

    @objc private func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        ILog.debug(tag: #file, content: "reload")

        refreshControl.endRefreshing()

        reloadData()
    }
    
    public func reloadData() {

        showProgress()

        ThreadUtil.startThread {

            var kaBeanArray: [KABean] = [KABean]()
            kaBeanArray.append(contentsOf: KADBWrapper.getInstance().getDataArray(offset: "0", limit: "10", category: self.category))

            ThreadUtil.startUIThread(runnable: {
                self.kaAccountListAdapter.reload(self.tableView, kaBeanArray: kaBeanArray)
                self.hideProgress()

            }, afterSeconds: 0)
        }
    }

    public func loadMoreData() {

        showProgress()

        ThreadUtil.startThread {

          var kaBeanArray: [KABean] = [KABean]()
          
            kaBeanArray.append(contentsOf: KADBWrapper.getInstance().getDataArray(offset: String(self.kaAccountListAdapter.getItemCount()), limit: "10", category: self.category))
            
            ThreadUtil.startUIThread(runnable: {

                self.kaAccountListAdapter.loadMore(self.tableView, kaBeanArray: kaBeanArray)
                self.hideProgress()

            }, afterSeconds: 0)
        }
    }

//    public func insertData() {
//
//        showProgress()
//
//        let content = self.textView.text!
//
//        ThreadUtil.startThread {
//
//            let checkInfoBean = CheckInfoBean(uuid: UUIDUtil.getUUID(), content: content, dateTime: DateUtil.getCurrentDateTimeStringWithStandardSQLiteDateTimeFromatter(), done: "N")
//
//            ILog.debug(tag: CheckListMainViewController.TAG, content: checkInfoBean.toString())
//
//            CLDBWrapper.getInstance().insert(checkInfoBean: checkInfoBean)
//
//            ThreadUtil.startUIThread(runnable: {
//
//                self.checkListAdapter.insertToFront(self.tableView, iBean: checkInfoBean)
//                self.hideProgress()
//
//            }, after: 0)
//        }
//    }
//
//    public func deleteData(iBean: IBean) {
//
//        showProgress()
//
//        ThreadUtil.startThread {
//
//            CLDBWrapper.getInstance().deleteData(checkInfoBean: iBean as! CheckInfoBean)
//
//            ThreadUtil.startUIThread(runnable: {
//
//                self.checkListAdapter.delete(self.tableView, iBean: iBean)
//                self.hideProgress()
//
//            }, after: 0)
//        }
//    }
//
//    public func updateData(iBean: IBean) {
//        showProgress()
//
//        ThreadUtil.startThread {
//
//            CLDBWrapper.getInstance().updateData(checkInfoBean: iBean as! CheckInfoBean)
//
//            ThreadUtil.startUIThread(runnable: {
//
//                self.checkListAdapter.update(self.tableView, iBean: iBean)
//                self.hideProgress()
//
//            }, after: 0)
//        }
//    }
//
    

    private func showProgress() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    private func hideProgress() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }

    deinit {
        NotificationUtil.removeAllObserver(observer: self)
//        CLDBWrapper.getInstance().closeDatabase()
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
