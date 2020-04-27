//
//  CheckListAdapter.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/27.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

extension CheckListMainViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 只有1列
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // row的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return checkInfoBeanList.count
    }
    
    // 载入cell并更新cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        ILog.debug(tag: CheckListMainViewController.TAG, content: "section index is \(indexPath.section)")
        ILog.debug(tag: CheckListMainViewController.TAG, content: "row index is \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckListItemTableViewCell.TAG, for: indexPath) as! CheckListItemTableViewCell

        cell.checkInfoBean = checkInfoBeanList[indexPath.row]
        
        cell.updateView()
        
        if indexPath.row == checkInfoBeanList.count - 1 {
            ILog.debug(tag: CheckListMainViewController.TAG, content: "load more")
            loadMoreData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 行左滑 编辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ILog.debug(tag: CheckListMainViewController.TAG, content: checkInfoBeanList[indexPath.row].toString()!)
            deleteData(checkInfoBean: checkInfoBeanList[indexPath.row])
        }
    }
    
    // 行左滑 自定义按钮
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton = UITableViewRowAction(style: UITableViewRowAction.Style.normal, title: "Delete", handler: { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
        })
        
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
    }
    
    // get item height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func reload(checkInfoBeanList: [CheckInfoBean]) {
        self.checkInfoBeanList.removeAll()
        self.checkInfoBeanList.append(contentsOf: checkInfoBeanList)
        self.tableView.reloadData()
    }
    
    public func loadMore(checkInfoBeanList: [CheckInfoBean]) {
        
        if checkInfoBeanList.count == 0 {
            return
        }
        
        var indexPathArray: [IndexPath] = [IndexPath]()
        
        ILog.debug(tag: CheckListMainViewController.TAG, content: checkInfoBeanList.count)
        
        for index in 0...checkInfoBeanList.count - 1 {
            let indexPath = IndexPath(row: getItemCount() + index, section: 0)
            indexPathArray.append(indexPath)
        }
        
        self.checkInfoBeanList.append(contentsOf: checkInfoBeanList)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPathArray, with: UITableView.RowAnimation.none)
        self.tableView.endUpdates()
    }
    
    public func getItemCount() -> Int {
        return self.checkInfoBeanList.count
    }
    
    public func insert(checkInfoBean: CheckInfoBean) {
        self.checkInfoBeanList.append(checkInfoBean)
        
        let indexPath = IndexPath(row: self.checkInfoBeanList.count - 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
   
    public func insertToFront(checkInfoBean: CheckInfoBean) {
        self.checkInfoBeanList.insert(checkInfoBean, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    public func delete(checkInfoBean: CheckInfoBean) {
        
        for index in 0..<checkInfoBeanList.count {
            if checkInfoBeanList[index].uuid == checkInfoBean.uuid {
                
                self.checkInfoBeanList.remove(at: index)
                
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                
                return
            }
        }
    }
    
    public func update(checkInfoBean: CheckInfoBean) {
        for index in 0..<checkInfoBeanList.count {
            if checkInfoBeanList[index].uuid == checkInfoBean.uuid {
                
                self.checkInfoBeanList[index] = checkInfoBean
                
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                
                return
            }
        }
    }
}
