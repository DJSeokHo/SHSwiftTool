//
//  IGLikeCollectionViewLayout.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2021/01/14.
//  Copyright © 2021 SWein. All rights reserved.
//

import Foundation
import UIKit

class IGLikeCollectionViewLayout: UICollectionViewFlowLayout {
    
    private var maxHeight: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        
        self.scrollDirection = .vertical
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect)!
      
        let width = DisplayUtil.getFullScreenSize().width
        
        for i in 0..<array.count {
            
            let attribute: UICollectionViewLayoutAttributes = array[i]
            
            var size: CGFloat = 0
            
            // calculate size
            if i % 18 == 0 || i % 18 == 10 {
                size = width / 3.0 * 2.0
            }
            else {
                size = width / 3.0
            }
            
            attribute.frame = CGRect(x: 0, y: 0, width: size, height: size)
        }
        
        for i in 0..<array.count {
         
            ILog.debug(tag: #file, content: "i \(i)")
            
            var x: CGFloat = 0
            var y: CGFloat = 0
            
            if i == 0 {
                x = 0
                y = 0
                
                ILog.debug(tag: #file, content: "first")
            }
            else {

                if array[i - 1].frame.maxX < width {
                    
                    if i % 3 == 0 {
                        x = 0
                        y = array[i - 1].frame.maxY
                        ILog.debug(tag: #file, content: "change row")
                    }
                    else {
                        // not yet to end
                        x = array[i - 1].frame.maxX
                        y = array[i - 1].frame.minY
                        ILog.debug(tag: #file, content: "not yet \(array[i - 1].frame.maxX)")
                    }
                    
                }
                else {
                    // to end
                   
                    // is array.count %3 == 0?
                    // if array.count %3 == 0 means need to change row
                    // next row's y is last item's maxY
                    if i % 3 == 0 {
                        
                        x = 0
                        y = array[i - 1].frame.maxY
                        ILog.debug(tag: #file, content: "change row")
                    }
                    // else array.count %3 != 0 means don not need to change row
                    else {
                        
                        ILog.debug(tag: #file, content: "put to end")
//                        ILog.debug(tag: #file, content: "i \(i) \(array[i - 1].frame.maxX)")
                        
//                        var currentIndex = 0
//                        var shortest = array[array.count - 2].frame.maxY
//                        for j in (0..<array.count - 1).reversed() {
//                            ILog.debug(tag: #file, content: "i \(i) j \(j) \(array[j].frame.maxY) ?? \(shortest)")
//                            if array[j].frame.maxY == width / 3.0 {
//
//                                currentIndex = j
//
//                            }
//                        }
//
//                        // lastest item's max y
//                        x = array[currentIndex].frame.minX
//                        y = array[currentIndex].frame.maxY
                        
                        var currentIndex = 0
                        
                       
                        if array[i - 1].frame.maxY < array[i - 2].frame.maxY {
                            currentIndex = i - 1
                        }
                        else {
                            currentIndex = i - 2
                        }
                      
                        ILog.debug(tag: #file, content: "\(array[i - 1].frame.maxY) \(array[i - 2].frame.maxY) so index is \(currentIndex)")
//                        for j in (0..<array.count).reversed() {
//                            ILog.debug(tag: #file, content: "i \(i) j \(j) \(array[j].frame.width) ??")
//                            if array[j].frame.width == width / 3.0 {
//
//                                currentIndex = j
//                                ILog.debug(tag: #file, content: "currentIndex is \(currentIndex)")
//                                break
//                            }
//                        }

                        // lastest item's max y
                        x = array[currentIndex].frame.minX
                        y = array[currentIndex].frame.maxY
                    }
                }

            }
            
            array[i].frame = CGRect(x: x, y: y, width: array[i].frame.width, height: array[i].frame.height)
            
            if array[array.count - 1].frame.maxY > array[array.count - 2].frame.maxY {
                maxHeight = array[array.count - 1].frame.maxY
            }
            else {
                maxHeight = array[array.count - 2].frame.maxY
            }
            
            ILog.debug(tag: #file, content: "\(array[array.count - 1].frame.maxY) \(array[array.count - 2].frame.maxY) so height is \(maxHeight)")
        }
        
        return array
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
//        ILog.debug(tag: #file, content: "collectionViewContentSize \(maxHeight)")
//        return CGSize(width: collectionView?.contentSize.width ?? 0, height: collectionView?.contentSize.height ?? 0)
        return CGSize(width: DisplayUtil.getFullScreenSize().width, height: 2208)
    }
}
