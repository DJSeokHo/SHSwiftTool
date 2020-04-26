//
//  CheckListMainNavigationBarViewHolder.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/27.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

protocol CheckListMainNavigationBarViewHolderDelegate {
    func onButtonEditClicked()
    func onButtonMoreClicked()
}

class CheckListMainNavigationBarViewHolder: UIView {
    
    private static let TAG = "CheckListMainNavigationBarViewHolder"
    
    @IBOutlet var buttonEdit: UIButton!
    @IBOutlet var buttonMore: UIButton!
    
    
    public var checkListMainNavigationBarViewHolderDelegate: CheckListMainNavigationBarViewHolderDelegate?
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        ILog.debug(tag: CheckListMainNavigationBarViewHolder.TAG, content: "override init \(frame.width) \(frame.height)")
        initialization()
    }
    deinit {
        ILog.debug(tag: CheckListMainNavigationBarViewHolder.TAG, content: "deinit")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ILog.debug(tag: CheckListMainNavigationBarViewHolder.TAG, content: "required init")
        initialization()
    }
    
    
    private func initialization() {
        ILog.debug(tag: CheckListMainNavigationBarViewHolder.TAG, content: "initialization")
        
        onCreateView()
        setListener()
    }
    
    private func onCreateView() {
        ILog.debug(tag: CheckListMainNavigationBarViewHolder.TAG, content: "onCreateView")
        let view = Bundle(for: type(of: self)).loadNibNamed(CheckListMainNavigationBarViewHolder.TAG, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
    
        addSubview(view)
        setListener()
    }
    
    private func setListener() {
       
        self.buttonEdit.addTarget(self, action: #selector(self.onButtonEditCLicked(_:)), for: UIControl.Event.touchUpInside)
        
        self.buttonMore.addTarget(self, action: #selector(self.onButtonMoreClicked(_:)), for: UIControl.Event.touchUpInside)
    }

    @objc private func onButtonEditCLicked(_ sender: UIButton) {
        self.checkListMainNavigationBarViewHolderDelegate?.onButtonEditClicked()
    }
    
    @objc private func onButtonMoreClicked(_ sender: UIButton) {
        self.checkListMainNavigationBarViewHolderDelegate?.onButtonMoreClicked()
    }
    
}
