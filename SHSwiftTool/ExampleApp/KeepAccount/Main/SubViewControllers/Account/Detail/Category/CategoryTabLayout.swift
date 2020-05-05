//
//  CategoryTabLayout.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/03.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class CategoryTabLayout: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public var collectionView: UICollectionView!
    public var categoryArray: [String] = [String]()

    public var frame: CGRect!
    
    public var onTabSelect: (() -> ())!
    
    public var currentCategory = KAConstants.CATEGORY_OTHER
    
    public func initTabLayout() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 110, height: 40)
        
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        
        collectionView.register(UINib(nibName: CategoryCollectionViewCell.TAG, bundle: nil), forCellWithReuseIdentifier: "cell")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        
        collectionView.allowsSelection = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell

        cell.category = categoryArray[indexPath.row]
      
        cell.onClickDelegate = {
            (category: String) in
            ILog.debug(tag: #file, content: "collectionView item click \(category)")
            self.currentCategory = category
            self.onTabSelect()
            collectionView.reloadData()
        }
        
        if (categoryArray[indexPath.row] == currentCategory) {
            cell.updateView(color: UIColor.black)
        }
        else {
            cell.updateView(color: UIColor.lightGray)
        }

        return cell;
    }
    
}
