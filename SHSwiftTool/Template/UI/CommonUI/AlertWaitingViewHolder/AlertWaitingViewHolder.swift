//
//  AlertWaitingViewHolder.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 17/08/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import Foundation
import UIKit

class AlertWaitingViewHolder: UIView {
    
    private static let TAG = "AlertWaitingViewHolder"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ILog.debug(tag: AlertWaitingViewHolder.TAG, content: "override init \(frame.width) \(frame.height)")
        initialization()
    }
    deinit {
        ILog.debug(tag: AlertWaitingViewHolder.TAG, content: "deinit")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ILog.debug(tag: AlertWaitingViewHolder.TAG, content: "required init")
        initialization()
    }
    
    
    private func initialization() {
        onCreateView()
    }
    
    private func onCreateView() {
        ILog.debug(tag: AlertWaitingViewHolder.TAG, content: "initialization")
        let view = Bundle(for: type(of: self)).loadNibNamed(AlertWaitingViewHolder.TAG, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        
        addSubview(view)
   
    }
    
}
