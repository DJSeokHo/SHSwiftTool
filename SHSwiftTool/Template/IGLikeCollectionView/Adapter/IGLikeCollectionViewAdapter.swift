//
//  IGLikeCollectionViewAdapter.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/01/13.
//  Copyright © 2021 SWein. All rights reserved.
//

import Foundation
import UIKit

extension IGLikeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IGLikeCollectionViewCell.TAG, for: indexPath) as! IGLikeCollectionViewCell
        
        cell.content = list[indexPath.row]
        
        if indexPath.row % 18 == 0 || indexPath.row % 18 == 10 {
            cell.backgroundColor = UIColor.red
        }
        else {
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.gray
            }
            else {
               
                cell.backgroundColor = UIColor.orange
            }
        }
        
        cell.updateView()
        
        return cell;
    
    }
   
}
