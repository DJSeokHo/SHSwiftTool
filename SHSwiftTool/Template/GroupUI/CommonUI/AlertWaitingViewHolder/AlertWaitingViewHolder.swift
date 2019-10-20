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
    
    private static let NIB_NAME = "AlertWaitingViewHolder"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialization()
    }
    
    deinit {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        initialization()
    }
    
    
    private func initialization() {
        onCreateView()
    }
    
    private func onCreateView() {
       
        let view = Bundle(for: type(of: self)).loadNibNamed(AlertWaitingViewHolder.NIB_NAME, owner: self, options: nil)?.first as! UIView
        
        view.frame = bounds
        
        addSubview(view)
    }
    
}
