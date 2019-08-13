//
//  NavigationBarViewHolder.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 12/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation
import UIKit

class NavigationBarViewHolder: UIView {
    
    private static let TAG = "NavigationBarViewHolder"
    
    @IBOutlet var buttonRight: UIButton!
    
    @IBOutlet var labelTitle: UILabel!
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        ILog.debug(tag: NavigationBarViewHolder.TAG, content: "override init \(frame.width) \(frame.height)")
        initialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ILog.debug(tag: NavigationBarViewHolder.TAG, content: "required init")
        initialization()
    }
    
    
    func initialization() {
        ILog.debug(tag: NavigationBarViewHolder.TAG, content: "initialization")
        let view = Bundle(for: type(of: self)).loadNibNamed("NavigationBarViewHolder", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        
        addSubview(view)
       
        labelTitle.text = "123"
        setListener()
    }
    
    private func setListener() {
       
        self.buttonRight.addTarget(self, action: #selector(self.onButtonRightClicked(_:)), for: UIControl.Event.touchUpInside)
    }

    @objc private func onButtonRightClicked(_ sender: UIButton) {
        ILog.debug(tag: NavigationBarViewHolder.TAG, content: "onButtonRightClicked")
    }
    
}
