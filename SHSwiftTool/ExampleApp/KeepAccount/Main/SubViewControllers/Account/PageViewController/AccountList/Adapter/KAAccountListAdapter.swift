//
//  KAAccountListAdapter.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class KAAccountListAdapter: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tag = "KAAccountListAdapter"
    
    private var kaInfoBeanArray: [KeepAccountInfoBean] = [KeepAccountInfoBean]()
    
    public var itemHeight: CGFloat!
    public var sectionNumber: Int!
    public var needLoadMore: Bool!
    public var canRowEdit: Bool!
    
    public var loadMoreDelegate: (() -> ())?
    public var deleteDelegate: ((_ keepAccountInfoBean: KeepAccountInfoBean) -> ())?
    
    func numberOfSections() -> Int {
        return sectionNumber
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kaInfoBeanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KAAccountListItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: KAAccountListItemTableViewCell.TAG, for: indexPath) as! KAAccountListItemTableViewCell
                
        cell.keepAccountInfoBean = kaInfoBeanArray[indexPath.row]
        cell.updateView()
            
        if indexPath.row == kaInfoBeanArray.count - 1 {
            ILog.debug(tag: tag, content: "load more")
            
            loadMoreDelegate?()
        }
            
        return cell
    }
    
    // edit
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ILog.debug(tag: tag, content: "delete ???")
            
            deleteDelegate?(kaInfoBeanArray[indexPath.row])
        }
    }

    // 行左滑 自定义按钮
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteButton = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "Delete", handler: { (action, indexPath) in
            tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt: indexPath)
        })

        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }
    
    public func reload(_ tableView: UITableView, kaInfoBeanArray: [KeepAccountInfoBean]) {
        self.kaInfoBeanArray.removeAll()
        self.kaInfoBeanArray.append(contentsOf: kaInfoBeanArray)
        tableView.reloadData()
    }
    
    public func loadMore(_ tableView: UITableView, kaInfoBeanArray: [KeepAccountInfoBean]) {
        
        if kaInfoBeanArray.count == 0 {
            return
        }
        
        var indexPathArray: [IndexPath] = [IndexPath]()
        
        ILog.debug(tag: tag, content: kaInfoBeanArray.count)
        
        for index in 0...kaInfoBeanArray.count - 1 {
            let indexPath = IndexPath(row: getItemCount() + index, section: 0)
            indexPathArray.append(indexPath)
        }
        
        self.kaInfoBeanArray.append(contentsOf: kaInfoBeanArray)
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathArray, with: UITableView.RowAnimation.none)
        tableView.endUpdates()
    }
    
    public func delete(_ tableView: UITableView, keepAccountInfoBean: KeepAccountInfoBean) {

        ILog.debug(tag: tag, content: "delete ??? \(keepAccountInfoBean.uuid!)")
        
        for index in 0..<kaInfoBeanArray.count {
            if kaInfoBeanArray[index].uuid == keepAccountInfoBean.uuid {

                self.kaInfoBeanArray.remove(at: index)

                let indexPath = IndexPath(row: index, section: 0)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

                return
            }
        }
    }
    
    public func insert(_ tableView: UITableView, keepAccountInfoBean: KeepAccountInfoBean) {
        self.kaInfoBeanArray.append(keepAccountInfoBean)

        let indexPath = IndexPath(row: self.kaInfoBeanArray.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    public func insertToFront(_ tableView: UITableView, keepAccountInfoBean: KeepAccountInfoBean) {
        self.kaInfoBeanArray.insert(keepAccountInfoBean, at: 0)

        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }

    public func update(_ tableView: UITableView, keepAccountInfoBean: KeepAccountInfoBean) {
        for index in 0..<kaInfoBeanArray.count {
            if kaInfoBeanArray[index].uuid == keepAccountInfoBean.uuid {
             
                self.kaInfoBeanArray[index] = keepAccountInfoBean

                let indexPath = IndexPath(row: index, section: 0)
                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

                return
            }
        }
    }
    
    public func getItemCount() -> Int {
        return kaInfoBeanArray.count
    }

    public func getCanRowEdit() -> Bool {
        return canRowEdit
    }
}

