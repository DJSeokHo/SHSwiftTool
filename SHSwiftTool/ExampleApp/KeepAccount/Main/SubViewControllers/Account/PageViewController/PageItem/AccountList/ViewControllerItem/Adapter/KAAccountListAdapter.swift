//
//  KAAccountListAdapter.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/08.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class KAAccountListAdapter: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var kaBeanArray: [KABean] = [KABean]()
    
    public var itemHeight: CGFloat!
    public var sectionNumber: Int!
    public var needLoadMore: Bool!
    public var canRowEdit: Bool!
    
    public var loadMoreDelegate: (() -> ())?
    public var deleteDelegate: ((_ kaBean: KABean) -> ())?
    public var noDataDelegate: ((_ noData: Bool) -> ())?
    
    func numberOfSections() -> Int {
        return sectionNumber
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kaBeanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kaCell: KACell = tableView.dequeueReusableCell(withIdentifier: KAAccountListItemTableViewCell.TAG, for: indexPath) as! KACell
                   
        kaCell.setData(kaBean: kaBeanArray[indexPath.row])
        kaCell.updateView()
            
        if indexPath.row == kaBeanArray.count - 1 {
            ILog.debug(tag: #file, content: "load more")
            
            loadMoreDelegate?()
        }
            
        return kaCell as! UITableViewCell
    }
   
    public func reload(_ tableView: UITableView, kaBeanArray: [KABean]) {
        self.kaBeanArray.removeAll()
        self.kaBeanArray.append(contentsOf: kaBeanArray)
        tableView.reloadData()
        
        if self.kaBeanArray.count == 0 {
            noDataDelegate?(true)
        }
        else {
            noDataDelegate?(false)
        }
    }
    
    public func loadMore(_ tableView: UITableView, kaBeanArray: [KABean]) {
        
        if kaBeanArray.count == 0 {
            return
        }
        
        var indexPathArray: [IndexPath] = [IndexPath]()
        
        ILog.debug(tag: #file, content: kaBeanArray.count)
        
        for index in 0...kaBeanArray.count - 1 {
            let indexPath = IndexPath(row: getItemCount() + index, section: 0)
            indexPathArray.append(indexPath)
        }
        
        self.kaBeanArray.append(contentsOf: kaBeanArray)
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathArray, with: UITableView.RowAnimation.none)
        tableView.endUpdates()
    }
    
    public func delete(_ tableView: UITableView, kaBean: KABean) {

        ILog.debug(tag: #file, content: "delete ??? \(kaBean.getUUID())")
        
        for index in 0..<kaBeanArray.count {
            if kaBeanArray[index].getUUID() == kaBean.getUUID() {

                self.kaBeanArray.remove(at: index)

                let indexPath = IndexPath(row: index, section: 0)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

                return
            }
        }
    }
    
    public func insert(_ tableView: UITableView, kaBean: KABean) {
        self.kaBeanArray.append(kaBean)

        let indexPath = IndexPath(row: self.kaBeanArray.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    public func insertToFront(_ tableView: UITableView, kaBean: KABean) {
        self.kaBeanArray.insert(kaBean, at: 0)

        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }

    public func update(_ tableView: UITableView, kaBean: KABean) {
        for index in 0..<kaBeanArray.count {
            if kaBeanArray[index].getUUID() == kaBean.getUUID() {
             
                self.kaBeanArray[index] = kaBean

                let indexPath = IndexPath(row: index, section: 0)
                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

                return
            }
        }
    }
    
    public func getItemCount() -> Int {
        return kaBeanArray.count
    }

}
