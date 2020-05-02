//
//  KATabLayout.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/02.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

protocol KATabLayoutDelegate {
    func onSelect(index: Int)
}

class KATabLayout: NSObject, UICollectionViewDelegate,UICollectionViewDataSource {
    
    public var collectionView: UICollectionView!
    public var titleArray: [String] = [String]()
    public var index: Int = 0
    public var frame: CGRect!
    
    public var kaTabLayoutDelegate: KATabLayoutDelegate!
    
    public func initTabLayout() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 60, height: 30)
        
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.cyan
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(KATabLayoutItemViewHolder.self, forCellWithReuseIdentifier: "cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! KATabLayoutItemViewHolder

        cell.title = titleArray[indexPath.row];
        
        if (indexPath.row == index) {
            cell.updateView(color: UIColor.black)
        }
        else {
            cell.updateView(color: UIColor.gray)
        }

        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        index = indexPath.row
        
        kaTabLayoutDelegate.onSelect(index: index)

        ILog.debug(tag: #file, content: "collectionView click \(index)")
        
        let indexPath: IndexPath = IndexPath(row: index, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
}
