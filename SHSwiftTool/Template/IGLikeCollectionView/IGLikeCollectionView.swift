//
//  IGLikeCollectionView.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/01/13.
//  Copyright © 2021 SWein. All rights reserved.
//

import UIKit

class IGLikeCollectionView: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
//    var gridLayout: UICollectionViewFlowLayout!
    var gridLayout: IGLikeCollectionViewLayout!
    
    var list: Array<String> = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        initList()
        
        for i in 0..<35 {
            list.append("index \(i)")
        }
        
        collectionView.reloadData()
    }

    private func initList() {
       
        list.removeAll()
        // init grid layout
//        gridLayout = UICollectionViewFlowLayout()
        gridLayout = IGLikeCollectionViewLayout()
        gridLayout.minimumLineSpacing = 1
        gridLayout.minimumInteritemSpacing = 1
//        gridLayout.itemSize = CGSize(width: CGFloat(DisplayUtil.getFullScreenSize().width) / 3.0 - 2, height: CGFloat(DisplayUtil.getFullScreenSize().width) / 3.0 - 2)
        gridLayout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1);
        
        collectionView.collectionViewLayout = gridLayout
        
        
        collectionView.register(UINib(nibName: IGLikeCollectionViewCell.TAG, bundle: nil), forCellWithReuseIdentifier: IGLikeCollectionViewCell.TAG)
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
