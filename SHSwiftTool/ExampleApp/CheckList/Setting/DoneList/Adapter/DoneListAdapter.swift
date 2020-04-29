//
//  DoneListAdapter.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/29.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class DoneListAdapter: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var iBeanArray: [IBean] = [IBean]()
    
    public var itemHeight: CGFloat!
    public var sectionNumber: Int!
    public var needLoadMore: Bool!
    public var canRowEdit: Bool!
    
    public var loadMoreDelegate: (() -> ())?
    public var deleteDelegate: ((_ iBean: IBean) -> ())?
    
    func numberOfSections() -> Int {
        return sectionNumber
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iBeanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iCell: ICell = tableView.dequeueReusableCell(withIdentifier: DoneListItemTableViewCell.TAG, for: indexPath) as! ICell
                   
        iCell.setData(iBean: iBeanArray[indexPath.row])
        iCell.updateView()
            
        if indexPath.row == iBeanArray.count - 1 {
            ILog.debug(tag: DoneListViewController.TAG, content: "load more")
            
            loadMoreDelegate?()
        }
            
        return iCell as! UITableViewCell
    }
    
    // 行左滑 编辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ILog.debug(tag: DoneListViewController.TAG, content: "delete ???")
            
            deleteDelegate?(iBeanArray[indexPath.row])
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
    
    public func reload(_ tableView: UITableView, iBeanArray: [IBean]) {
        self.iBeanArray.removeAll()
        self.iBeanArray.append(contentsOf: iBeanArray)
        tableView.reloadData()
    }
    
    public func loadMore(_ tableView: UITableView, iBeanArray: [IBean]) {
        
        if iBeanArray.count == 0 {
            return
        }
        
        var indexPathArray: [IndexPath] = [IndexPath]()
        
        ILog.debug(tag: DoneListViewController.TAG, content: iBeanArray.count)
        
        for index in 0...iBeanArray.count - 1 {
            let indexPath = IndexPath(row: getItemCount() + index, section: 0)
            indexPathArray.append(indexPath)
        }
        
        self.iBeanArray.append(contentsOf: iBeanArray)
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathArray, with: UITableView.RowAnimation.none)
        tableView.endUpdates()
    }
    
    public func delete(_ tableView: UITableView, iBean: IBean) {

        ILog.debug(tag: DoneListViewController.TAG, content: "delete ??? \(iBean.getId())")
        
        for index in 0..<iBeanArray.count {
            if iBeanArray[index].getId() == iBean.getId() {

                self.iBeanArray.remove(at: index)

                let indexPath = IndexPath(row: index, section: 0)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

                return
            }
        }
    }
    
    public func getItemCount() -> Int {
        return iBeanArray.count
    }
    
    public func getCanRowEdit() -> Bool {
        return canRowEdit
    }
}
