//
//  KATabLayout.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/02.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class KATabLayout: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public var collectionView: UICollectionView!
    public var titleArray: [String] = [String]()
    public var index: Int = 0
    public var frame: CGRect!
    
    public var onTabSelect: ((_ index: Int) -> ())!
    
    public func initTabLayout() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 30)
        
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        
        collectionView.register(UINib(nibName: KATabLayoutItemViewHolder.TAG, bundle: nil), forCellWithReuseIdentifier: "cell")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        
        collectionView.allowsSelection = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! KATabLayoutItemViewHolder

        cell.title = titleArray[indexPath.row];
        cell.index = indexPath.row
        cell.onClickDelegate = {
            (index: Int) in
            ILog.debug(tag: #file, content: "collectionView item click \(index)")
            self.onTabSelect(index)
        }
        
        if (indexPath.row == index) {
            cell.updateView(color: UIColor.black)
        }
        else {
            cell.updateView(color: UIColor.gray)
        }

        return cell;
    }
    
}
