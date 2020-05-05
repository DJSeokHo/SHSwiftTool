//
//  CustomCenterSelectUITabBar.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

class CustomCenterSelectUITabBar: UITabBar {
    
    public weak var customCenterSelectUITabBarDelegate: CustomCenterSelectUITabBarDelegate?
    
    private lazy var plusButton: UIButton = {
        return UIButton()
    }()
    
    public var centerButtonIndex: Int = 1
    public var buttonNumber: Int = 3
    
    private var isButtonSelected = false
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = ColorUtil.colorWithHexString("ffffff")

        // if ture, will show light grey
        // if you need set color, than
        self.isTranslucent = true
        
        plusButton.setBackgroundImage(UIImage.init(named: "icon_keep_account"), for: .normal)
        plusButton.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
        
        self.addSubview(plusButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addButtonClick() {
        if customCenterSelectUITabBarDelegate != nil{
            customCenterSelectUITabBarDelegate?.onPlusClick()
            
        }
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
      
        changeTopSplitLineColor(color: ColorUtil.colorWithHexString("ffffff"))
        
        let buttonX = self.frame.size.width / CGFloat(buttonNumber)
        var index = 0
        for barButton in self.subviews {
            
            if barButton.isKind(of: NSClassFromString("UITabBarButton")!){
                
                if index == centerButtonIndex {
                    // set center button

                    plusButton.frame.size = CGSize.init(width: 60, height: 60)
                    plusButton.center = CGPoint.init(x: self.center.x, y: 10)
                    
                    barButton.isHidden = true
                }
                
                barButton.frame = CGRect.init(x: buttonX * CGFloat(index), y: 0, width: buttonX, height: self.frame.size.height - 16)
                index += 1
            }
        }
        
        self.bringSubviewToFront(plusButton)
    }
    
    /// 重写hitTest方法，监听按钮的点击 让中间按钮响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        else {
            // 将单钱触摸点转换到按钮上生成新的点
            let onButton = self.convert(point, to: self.plusButton)
            
            // 判断新的点是否在按钮上
            if self.plusButton.point(inside: onButton, with: event){
                return plusButton
            }
            else {
                return super.hitTest(point, with: event)
            }
        }
    }
}
