//
//  CustomNormalUITabBar.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class CustomNormalUITabBar: UITabBar {
   
    public var buttonNumber: Int = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        // if ture, will show light grey
        self.isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func changeTopSplitLineColor(color: UIColor) {
           
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1);
        view.center = CGPoint.init(x: self.center.x, y: 0)
        view.backgroundColor = color
        self.addSubview(view)
        
        self.bringSubviewToFront(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        changeTopSplitLineColor(color: ColorUtil.colorWithHexString("666666"))
        
        let buttonX = self.frame.size.width / CGFloat(buttonNumber)
        var index = 0
        for barButton in self.subviews {
            
            if barButton.isKind(of: NSClassFromString("UITabBarButton")!){
              
                barButton.frame = CGRect.init(x: buttonX * CGFloat(index), y: 0, width: buttonX, height: self.frame.size.height - 16)
                index += 1
            }
        }
        
    }
    
    /// 重写hitTest方法，监听按钮的点击 让中间按钮响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        return super.hitTest(point, with: event)
        
    }
}
