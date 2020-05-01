//
//  KANavigationBarViewHolder.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

protocol KANavigationBarViewHolderDelegate {
    func onLeftButtonClick()
    func onRightButtonClick()
}

class KANavigationBarViewHolder: UIView {
    
    @IBOutlet var buttonLeft: UIButton!
    @IBOutlet var buttonRight: UIButton!
    @IBOutlet var labelTitle: UILabel!
    
    @IBOutlet var bottomLine: UIView!
    
    
    public var kaNavigationBarViewHolderDelegate: KANavigationBarViewHolderDelegate?
    
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
        setListener()
    }

    private func onCreateView() {

        let view = Bundle(for: type(of: self)).loadNibNamed("KANavigationBarViewHolder", owner: self, options: nil)?.first as! UIView
        view.frame = bounds

        addSubview(view)
        setListener()
    }

    private func setListener() {

        self.buttonLeft.addTarget(self, action: #selector(self.onButtonLeftClicked), for: UIControl.Event.touchUpInside)
        self.buttonRight.addTarget(self, action: #selector(self.onButtonRightClicked), for: UIControl.Event.touchUpInside)
    }

    public func setTitle(title: String) {
        labelTitle.text = title
    }
    
    public func setLeftButtonImage(imageName: String) {
        buttonLeft.isHidden = false
        buttonLeft.setImage(UIImage(named: imageName), for: UIControl.State.normal)
    }
    
    public func setRightButtonImage(imageName: String) {
         buttonRight.isHidden = false
         buttonRight.setImage(UIImage(named: imageName), for: UIControl.State.normal)
    }
    
    public func hideLeftButton() {
        buttonLeft.isHidden = true
    }
    
    public func hideRightButton() {
         buttonRight.isHidden = true
    }

    @objc private func onButtonLeftClicked(_ sender: UIButton) {
        self.kaNavigationBarViewHolderDelegate?.onLeftButtonClick()
    }
    
    @objc private func onButtonRightClicked(_ sender: UIButton) {
        self.kaNavigationBarViewHolderDelegate?.onRightButtonClick()
    }
}
