//
//  SimpleNavigationBarViewHolder.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/29.
//  Copyright © 2020 SWein. All rights reserved.
//

import Foundation
import UIKit

protocol SimpleNavigationBarViewHolderDelegate {
    func onButtonBackClicked()
}

class SimpleNavigationBarViewHolder: UIView {
    
    private static let TAG = "SimpleNavigationBarViewHolder"
     
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var buttonBack: UIButton!

    public var simpleNavigationBarViewHolderDelegate: SimpleNavigationBarViewHolderDelegate?

     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ILog.debug(tag: SimpleNavigationBarViewHolder.TAG, content: "override init \(frame.width) \(frame.height)")
        initialization()
    }
    deinit {
        ILog.debug(tag: SimpleNavigationBarViewHolder.TAG, content: "deinit")
    }

    required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
        ILog.debug(tag: SimpleNavigationBarViewHolder.TAG, content: "required init")
        initialization()
    }


    private func initialization() {
        ILog.debug(tag: SimpleNavigationBarViewHolder.TAG, content: "initialization")

        onCreateView()
        setListener()
    }

    private func onCreateView() {
        ILog.debug(tag: SimpleNavigationBarViewHolder.TAG, content: "onCreateView")
        let view = Bundle(for: type(of: self)).loadNibNamed(SimpleNavigationBarViewHolder.TAG, owner: self, options: nil)?.first as! UIView
        view.frame = bounds

        addSubview(view)
        setListener()
    }

    private func setListener() {

        self.buttonBack.addTarget(self, action: #selector(self.onButtonBackCLicked(_:)), for: UIControl.Event.touchUpInside)
    }

    public func setTitle(title: String) {
        labelTitle.text = title
    }

    @objc private func onButtonBackCLicked(_ sender: UIButton) {
        self.simpleNavigationBarViewHolderDelegate?.onButtonBackClicked()
    }

}
