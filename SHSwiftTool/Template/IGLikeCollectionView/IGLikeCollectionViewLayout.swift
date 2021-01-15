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
    
    private var numberOfItem: Int = 0
    private var frameInfoList: [CGRect] = []
    
    override init() {
        super.init()
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        numberOfItem = collectionView?.numberOfItems(inSection: 0) ?? 0
        
        ILog.debug(tag: #file, content: "prepare~~~~~~~~~~~~~~~~~~~~~~~~~ numberOfItems \(numberOfItem)")
        
        calculateFrame()
    }
 
    private func setting() {
        self.scrollDirection = .vertical
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    private func calculateFrame() {
        
        if frameInfoList.count == numberOfItem {
            return
        }
        
        ILog.debug(tag: #file, content: "calculateFrame~~~~~~~~~~~~~~~~~~~~~~~~~ frameInfoList \(frameInfoList.count)")
        
        let width = DisplayUtil.getFullScreenSize().width
        
        var startIndex = 0
        
        if !frameInfoList.isEmpty {
            startIndex = frameInfoList.count
        }
        
        for i in startIndex..<numberOfItem {
            
            var size: CGFloat = 0
            
            // calculate size
            if i % 18 == 0 || i % 18 == 10 {
                size = width / 3.0 * 2.0
            }
            else {
                size = width / 3.0
            }
            
            frameInfoList.append(CGRect(x: 0, y: 0, width: size, height: size))
        }
        
        for i in startIndex..<frameInfoList.count {
          
            ILog.debug(tag: #file, content: "i \(i)")

            var x: CGFloat = 0
            var y: CGFloat = 0

            if i == 0 {
                x = 0
                y = 0

                ILog.debug(tag: #file, content: "first")
            }
            else {

                if frameInfoList[i - 1].maxX < width {

                    if i % 3 == 0 {
                        x = 0
                        y = frameInfoList[i - 1].maxY
                        ILog.debug(tag: #file, content: "change row")
                    }
                    else {
                        // not yet to end
                        x = frameInfoList[i - 1].maxX
                        y = frameInfoList[i - 1].minY
                        ILog.debug(tag: #file, content: "not yet \(frameInfoList[i - 1].maxX)")
                    }

                }
                else {
                    // to end

                    // is array.count %3 == 0?
                    // if array.count %3 == 0 means need to change row
                    // next row's y is last item's maxY
                    if i % 3 == 0 {

                        x = 0
                        y = frameInfoList[i - 1].maxY
                        ILog.debug(tag: #file, content: "change row")
                    }
                    // else array.count %3 != 0 means don not need to change row
                    else {

                        ILog.debug(tag: #file, content: "put to end")

                        var currentIndex = 0

                        if frameInfoList[i - 1].maxY < frameInfoList[i - 2].maxY {
                            currentIndex = i - 1
                        }
                        else {
                            currentIndex = i - 2
                        }

                        ILog.debug(tag: #file, content: "\(frameInfoList[i - 1].maxY) \(frameInfoList[i - 2].maxY) so index is \(currentIndex)")

                        // lastest item's max y
                        x = frameInfoList[currentIndex].minX
                        y = frameInfoList[currentIndex].maxY
                    }
                }

            }

            frameInfoList[i] = CGRect(x: x, y: y, width: frameInfoList[i].width, height: frameInfoList[i].height)
            
            ILog.debug(tag: #file, content: "frame start position is \(frameInfoList[i].minX) \(frameInfoList[i].minY)")
        }
        
        if frameInfoList[frameInfoList.count - 1].maxY > frameInfoList[frameInfoList.count - 2].maxY {
            maxHeight = frameInfoList[frameInfoList.count - 1].maxY
        }
        else {
            maxHeight = frameInfoList[frameInfoList.count - 2].maxY
        }
        
        ILog.debug(tag: #file, content: "\(frameInfoList[frameInfoList.count - 1].maxY) \(frameInfoList[frameInfoList.count - 2].maxY) so height is \(maxHeight)")
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      
        // calculate frame position
//        for i in 0..<frameInfoList.count {
//
//            ILog.debug(tag: #file, content: "i \(i)")
//
//            var x: CGFloat = 0
//            var y: CGFloat = 0
//
//            if i == 0 {
//                x = 0
//                y = 0
//
//                ILog.debug(tag: #file, content: "first")
//            }
//            else {
//
//                if frameInfoList[i - 1].maxX < width {
//
//                    if i % 3 == 0 {
//                        x = 0
//                        y = frameInfoList[i - 1].maxY
//                        ILog.debug(tag: #file, content: "change row")
//                    }
//                    else {
//                        // not yet to end
//                        x = frameInfoList[i - 1].maxX
//                        y = frameInfoList[i - 1].minY
//                        ILog.debug(tag: #file, content: "not yet \(frameInfoList[i - 1].maxX)")
//                    }
//
//                }
//                else {
//                    // to end
//
//                    // is array.count %3 == 0?
//                    // if array.count %3 == 0 means need to change row
//                    // next row's y is last item's maxY
//                    if i % 3 == 0 {
//
//                        x = 0
//                        y = frameInfoList[i - 1].maxY
//                        ILog.debug(tag: #file, content: "change row")
//                    }
//                    // else array.count %3 != 0 means don not need to change row
//                    else {
//
//                        ILog.debug(tag: #file, content: "put to end")
//
//                        var currentIndex = 0
//
//
//                        if frameInfoList[i - 1].maxY < frameInfoList[i - 2].maxY {
//                            currentIndex = i - 1
//                        }
//                        else {
//                            currentIndex = i - 2
//                        }
//
//                        ILog.debug(tag: #file, content: "\(frameInfoList[i - 1].maxY) \(frameInfoList[i - 2].maxY) so index is \(currentIndex)")
//
//                        // lastest item's max y
//                        x = frameInfoList[currentIndex].minX
//                        y = frameInfoList[currentIndex].maxY
//                    }
//                }
//
//            }
//
//            frameInfoList[i] = CGRect(x: x, y: y, width: frameInfoList[i].width, height: frameInfoList[i].height)
//
//            if frameInfoList[frameInfoList.count - 1].maxY > frameInfoList[frameInfoList.count - 2].maxY {
//                maxHeight = frameInfoList[frameInfoList.count - 1].maxY
//            }
//            else {
//                maxHeight = frameInfoList[frameInfoList.count - 2].maxY
//            }
//
////            superArray[i].frame = frameInfoList[i]
//            ILog.debug(tag: #file, content: "\(frameInfoList[frameInfoList.count - 1].maxY) \(frameInfoList[frameInfoList.count - 2].maxY) so height is \(maxHeight)")
//        }

        
        var returnFrameList:[UICollectionViewLayoutAttributes] = []
        // calculate the view that will return can be visible in rect range
//        guard let superArray = super.layoutAttributesForElements(in: rect) else { return nil }
        
        let offset: CGPoint = collectionView!.contentOffset
        let visibleRect: CGRect = CGRect(x: 0, y: offset.y, width: collectionView!.frame.width, height: collectionView!.frame.height)
        ILog.debug(tag: #file, content: "in rect \(visibleRect.size.width) \(visibleRect.size.height) \(visibleRect.minY) \(visibleRect.maxY) offset: \(offset.y)")
        
        for i in 0..<frameInfoList.count {
        
            let indexPath = IndexPath(row: i, section: 0)
            let frame = super.layoutAttributesForItem(at: indexPath)
            
            // check is frame info in visible rect
            if frameInfoList[i].maxY >= visibleRect.minY {
                // top part cross, so need add
                frame?.frame = frameInfoList[i]
                returnFrameList.append(frame ?? UICollectionViewLayoutAttributes())
            }
            else if frameInfoList[i].minY <= frameInfoList[i].maxY {
                // bottom part cross, so need add
                frame?.frame = frameInfoList[i]
                returnFrameList.append(frame ?? UICollectionViewLayoutAttributes())
            }
            else if frameInfoList[i].minY < visibleRect.minY || frameInfoList[i].maxY < visibleRect.maxY {
                // in the rect, so need add
                frame?.frame = frameInfoList[i]
                returnFrameList.append(frame ?? UICollectionViewLayoutAttributes())
            }
           
        }
        
        return returnFrameList
//        var attributesArray: Array<UICollectionViewLayoutAttributes> = []
//        let offset: CGPoint = collectionView!.contentOffset
//        let visibleRect: CGRect = CGRect(x: 0, y: offset.y, width: collectionView!.frame.width, height: collectionView!.frame.height)
//
//        ILog.debug(tag: #file, content: "offset is \(offset)")
//
//        guard let tempArray = super.layoutAttributesForElements(in: rect) else { return nil }
//
//
//        let width = DisplayUtil.getFullScreenSize().width
//
//        for i in 0..<tempArray.count {
//
//            let attribute: UICollectionViewLayoutAttributes = tempArray[i]
//
//            var size: CGFloat = 0
//
//            // calculate size
//            if i % 18 == 0 || i % 18 == 10 {
//                size = width / 3.0 * 2.0
//            }
//            else {
//                size = width / 3.0
//            }
//
//            attribute.frame = CGRect(x: 0, y: 0, width: size, height: size)
//        }
//
//        for i in 0..<tempArray.count {
//
//            ILog.debug(tag: #file, content: "i \(i)")
//
//            var x: CGFloat = 0
//            var y: CGFloat = 0
//
//            if i == 0 {
//                x = 0
//                y = 0
//
////                ILog.debug(tag: #file, content: "first")
//            }
//            else {
//
//                if tempArray[i - 1].frame.maxX < width {
//
//                    if i % 3 == 0 {
//                        x = 0
//                        y = tempArray[i - 1].frame.maxY
////                        ILog.debug(tag: #file, content: "change row")
//                    }
//                    else {
//                        // not yet to end
//                        x = tempArray[i - 1].frame.maxX
//                        y = tempArray[i - 1].frame.minY
////                        ILog.debug(tag: #file, content: "not yet \(tempArray[i - 1].frame.maxX)")
//                    }
//
//                }
//                else {
//                    // to end
//
//                    // is array.count %3 == 0?
//                    // if array.count %3 == 0 means need to change row
//                    // next row's y is last item's maxY
//                    if i % 3 == 0 {
//
//                        x = 0
//                        y = tempArray[i - 1].frame.maxY
////                        ILog.debug(tag: #file, content: "change row")
//                    }
//                    // else array.count %3 != 0 means don not need to change row
//                    else {
//
////                        ILog.debug(tag: #file, content: "put to end")
//
////                        // lastest item's max y
////                        x = array[currentIndex].frame.minX
////                        y = array[currentIndex].frame.maxY
//
//                        var currentIndex = 0
//
//
//                        if tempArray[i - 1].frame.maxY < tempArray[i - 2].frame.maxY {
//                            currentIndex = i - 1
//                        }
//                        else {
//                            currentIndex = i - 2
//                        }
//
////                        ILog.debug(tag: #file, content: "\(tempArray[i - 1].frame.maxY) \(tempArray[i - 2].frame.maxY) so index is \(currentIndex)")
//
//                        // lastest item's max y
//                        x = tempArray[currentIndex].frame.minX
//                        y = tempArray[currentIndex].frame.maxY
//                    }
//                }
//
//            }
//
//            tempArray[i].frame = CGRect(x: x, y: y, width: tempArray[i].frame.width, height: tempArray[i].frame.height)
//
//            if tempArray[tempArray.count - 1].frame.maxY > tempArray[tempArray.count - 2].frame.maxY {
//                maxHeight = tempArray[tempArray.count - 1].frame.maxY
//            }
//            else {
//                maxHeight = tempArray[tempArray.count - 2].frame.maxY
//            }
//
////            ILog.debug(tag: #file, content: "\(tempArray[tempArray.count - 1].frame.maxY) \(tempArray[tempArray.count - 2].frame.maxY) so height is \(maxHeight)")
//
//        }
//
//        attributesArray.append(contentsOf: tempArray)
//        return attributesArray
////        return tempArray
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        ILog.debug(tag: #file, content: "collectionViewContentSize \(maxHeight)")
        return CGSize(width: DisplayUtil.getFullScreenSize().width, height: maxHeight)
    }
}
