//
//  CALAdapter.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/03/18.
//  Copyright © 2021 SWein. All rights reserved.
//

import Foundation
import UIKit

extension CollectionAutoLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CALItemCollectionViewCellDelegate {
    
    func onClick(_ bean: CALItemBean) {
        
        let index = list.firstIndex{$0 === bean}!
        ILog.debug(tag: #file, content: "\(index)")
        
        bean.isImage = !bean.isImage
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])

    }
    
    
    // pull to refresh
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       
        if refreshControl.isRefreshing {
            
            ILog.debug(tag: #file, content: "reload")
             
            self.reload()
            self.refreshControl.endRefreshing()
           
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        ILog.debug(tag: #file, content: "here??? \(indexPath.row)")
        
        if list[indexPath.row].isImage {
            return CGSize(width: DisplayUtil.getFullScreenSize().width, height: 225)
        }
        
        return CGSize(width: DisplayUtil.getFullScreenSize().width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        weak var cell = collectionView.dequeueReusableCell(withReuseIdentifier: CALItemCollectionViewCell.TAG, for: indexPath) as? CALItemCollectionViewCell

        cell?.delegate = self
        cell?.bean = list[indexPath.row]
        cell?.updateView()
   
        return cell ?? CALItemCollectionViewCell()
    
    }
    
    func reloadData(list: [CALItemBean]) {
        self.list.removeAll()
        self.list.append(contentsOf: list)
        collectionView.reloadData()
    }
    
}

